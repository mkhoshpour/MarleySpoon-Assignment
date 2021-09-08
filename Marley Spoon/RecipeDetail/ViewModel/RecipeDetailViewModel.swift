//
//  RecipeDetailViewModel.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/7/21.
//

import Foundation

class RecipeDetailViewModel {

    // Variables
    var recipeLoaded: ((Recipe) -> Void)?
    var errorHandler: ((String) -> Void)?
    var loading: ((Bool) -> Void)?
    public var recipe: Recipe!

    func getRecipe() {
        self.loading?(true)
        Service.fetchRecipes(id: recipe.id, result: { [weak self] result in
            guard let self = self else { return }
            self.loading?(false)
            switch result {
            case .success(let recipe):
                self.recipe = recipe
                self.recipeLoaded?(recipe)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        })
    }

    public func reload() {
        self.getRecipe()
    }
}
