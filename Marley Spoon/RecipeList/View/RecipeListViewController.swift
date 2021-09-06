//
//  RecipeListViewController.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/5/21.
//

import UIKit

class RecipeListViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Customizing View
    func setupView() {

    }

    // MARK: - Bindings
    private func setupBindings() {

        // Subscribe to Loading
        apartmentsViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.loading.startAnimating() : self.loading.stopAnimating()
        }

        // Subscribe to apartments
        apartmentsViewModel.apartments = { [weak self] apartments in
            guard let self = self else { return }
            // Add new apartments to tableView dataSource.
            self.apartmentsTableViewDataSource.refreshWithNewItems(apartments)
        }

        // Subscribe to errors
        apartmentsViewModel.errorHandler = { [weak self] error in
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: RecipeCell.self)) {
            let recipe = recipes[indexPath.row]
            
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
}