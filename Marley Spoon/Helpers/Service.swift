//
//  Service.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/5/21.
//

import Foundation
import Contentful
import Kingfisher

typealias RecipesResult = (Result<[Recipe], Error>) -> Void
typealias SingleRecipeResult = (Result<Recipe, Error>) -> Void
typealias ImageResult = (Result<UIImage, Error>) -> Void

class RecipeService: NSObject {

    static let client = Client(spaceId: "kk2bw5ojx476",
                        accessToken: "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c",
                        contentTypeClasses: [Recipe.self, Chef.self, Tag.self])

    static func fetchRecipes(result : @escaping RecipesResult) {
        let query = QueryOn<Recipe>.where(contentTypeId: "recipe")
        RecipeService.client.fetchArray(of: Recipe.self, matching: query) {(response: Result<HomogeneousArrayResponse<Recipe>, Error>) in
            switch response {
            case .success(let entry):
                print(entry)
                result(.success(entry.items))
            case .failure(let error):
                print("Error \(error)!")
                result(.failure(error))
            }
        }
    }

    static func fetchRecipes(id: String, result : @escaping SingleRecipeResult) {
        RecipeService.client.fetch(Recipe.self, id: id) { (response: Result<Recipe, Error>) in
            switch response {
            case .success(let entry):
                print(entry)
                result(.success(entry))
            case .failure(let error):
                print("Error \(error)!")
                result(.failure(error))
            }
        }
    }

    static func loadImage(url: URL, result: @escaping ImageResult) {
        // KingFisher needs imageView to set image to, but we only need image

        KF.url(url)
            .placeholder(UIImage(named: "foodPlaceholder"))
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onSuccess { data in
                if let image = data.image.imageAsset?.image(with: .current) {
                    result(.success(image))
                }
            }
            .onFailure { error in
                print(error)
            }
            .set(to: UIImageView())
    }
}
