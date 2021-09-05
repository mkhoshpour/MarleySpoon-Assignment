//
//  Service.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/5/21.
//

import Foundation
import Contentful

typealias RecipesResult = (Result<[Recipe], Error>) -> Void

class Service: NSObject {

    static let client = Client(spaceId: "kk2bw5ojx476",
                        accessToken: "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c",
                        contentTypeClasses: [Recipe.self, Chef.self, Tag.self])

    static func fetchRecipes(result : @escaping RecipesResult) {
        let query = QueryOn<Recipe>.where(contentTypeId: "recipe")
        Service.client.fetchArray(of: Recipe.self, matching: query) {(response: Result<HomogeneousArrayResponse<Recipe>, Error  >) in
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
}
