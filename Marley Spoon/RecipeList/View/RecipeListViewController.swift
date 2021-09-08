//
//  RecipeListViewController.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/5/21.
//

import UIKit

class RecipeListViewController: UIViewController, Storyboarded {

    // MARK: - UI Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var loading: UIActivityIndicatorView! {
        didSet {
            loading.hidesWhenStopped = true
        }
    }
    var cellHeight: CGFloat = 231

    // MARK: - Variables
    var recipes: [Recipe]?
    let recipesViewModel = RecipeListViewModel()
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        recipesViewModel.getRecipes()
        // Do any additional setup after loading the view.
    }

    // MARK: - Customizing View
    func setupView() {
        self.tableView.registerCell(type: RecipeCell.self)
        // This will remove extra separators from tableview
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Bindings
    private func setupBindings() {

        // Subscribe to Loading
        recipesViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                isLoading ? self.loading.startAnimating() : self.loading.stopAnimating()
            }
        }

        // Subscribe to apartments
        recipesViewModel.recipesLoaded = { [weak self] recipes in
            guard let self = self else { return }
            // Add new apartments to tableView dataSource.
            self.recipes = recipes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        // Subscribe to errors
        recipesViewModel
            .errorHandler = { [weak self] error in
            guard let self = self else { return }
            self.showAlertWith(error, title: "Error", completion: nil)
        }
    }

}

// MARK: - UITableView DataSource
extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueCell(withType: RecipeCell.self) as? RecipeCell {
            if let recipe = recipes?[indexPath.row] {
                cell.configureCellWith(recipe)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }

}

// MARK: - UITableView Delegate
extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let recipe = recipes?[indexPath.row] {
            self.coordinator?.navigateToDetailView(recipe)
        }

    }
}
