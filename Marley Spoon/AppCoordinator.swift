//
//  AppCoordinator.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/6/21.
//

import UIKit

final class AppCoordinator: NSObject {

    // MARK: - Variables
    let window: UIWindow?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
        super.init()

    }

    // Start of the app
    func start(animated: Bool) {
        guard let window = window else { return }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let recipeListViewController = RecipeListViewController.instantiate(coordinator: self)
        navigationController.pushViewController(recipeListViewController, animated: true)
    }

    func navigateToDetailView(_ recipe: Recipe) {
        let detailViewController = RecipeDetailViewController.instantiate(coordinator: self)
        detailViewController.recipeViewModel.recipe = recipe
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
