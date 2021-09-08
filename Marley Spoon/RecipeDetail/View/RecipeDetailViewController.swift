//
//  RecipeDetailViewController.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/7/21.
//

import UIKit

class RecipeDetailViewController: UIViewController, Storyboarded {

    // MARK: - UI Properties
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageRecipeImage: UIImageView!
    @IBOutlet weak var collectionViewTags: UICollectionView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var viewChef: UIView!
    @IBOutlet weak var labelChefName: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    // MARK: - Variables
    weak var coordinator: AppCoordinator?
    let recipeViewModel = RecipeDetailViewModel()
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        recipeViewModel.getRecipe()
        // Do any additional setup after loading the view.
    }

    // MARK: - Customizing View
    func setupView() {
        self.collectionViewTags.registerCell(type: TagCell.self)
        if let flowLayout = collectionViewTags?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

        // Image View
        imageRecipeImage.layer.cornerRadius = 15
        imageRecipeImage?.layer.masksToBounds = true

        // Chef View
        viewChef.layer.cornerRadius = 15
        viewChef?.layer.masksToBounds = true
    }

    func setData() {
        labelTitle.text = recipe?.title
        labelDescription.text = recipe?.description
        if let chefName = recipe?.chef?.name {
            labelChefName.text = chefName
            viewChef.isHidden = false
        } else {
            viewChef.isHidden = true
        }
        if let url = recipe?.photo?.url {
            Service.loadImage(url: url) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.imageRecipeImage.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        collectionViewTags.reloadData()
    }

    // MARK: - Bindings
    private func setupBindings() {

        // Subscribe to Loading
        recipeViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                isLoading ? self.loading.startAnimating() : self.loading.stopAnimating()
            }
        }

        // Subscribe to apartments
        recipeViewModel.recipeLoaded = { [weak self] recipe in
            guard let self = self else { return }
            // Add new apartments to tableView dataSource.
            self.recipe = recipe
            DispatchQueue.main.async {
                self.setData()
            }
        }

        // Subscribe to errors
        recipeViewModel.errorHandler = { [weak self] error in
            guard let self = self else { return }
            self.showAlertWith(error, title: "Error", completion: nil)
        }
    }

}

// MARK: - UICollectionView DataSource
extension RecipeDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipe?.tags?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueCell(withType: TagCell.self, for: indexPath) as? TagCell {
            if let tag = recipe?.tags?[indexPath.row] {
                cell.configureCellWith(tag)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}

// MARK: - UICollectionView DelegateFlowLayout
extension RecipeDetailViewController: UICollectionViewDelegateFlowLayout {

}
