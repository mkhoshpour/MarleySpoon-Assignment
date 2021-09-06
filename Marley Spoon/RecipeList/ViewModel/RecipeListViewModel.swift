//
//  RecipeListViewModel.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/6/21.
//

import Foundation

class RecipeListViewModel {

    // Variables
    var recipesLoaded: (([Recipe]) -> Void)?
    var errorHandler: ((String) -> Void)?
    var loading: ((Bool) -> Void)?
    public var recipes: [Recipe] = []

    func getRecipes() {
        self.loading?(true)
        Service.fetchRecipes { [weak self] result in
            guard let self = self else { return }
            self.loading?(false)
            switch result {
            case .success(let recipes):
                self.recipes.append(contentsOf: recipes)
                self.recipesLoaded?(recipes)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }

    public func reload() {
        self.getRecipes()
    }
}
