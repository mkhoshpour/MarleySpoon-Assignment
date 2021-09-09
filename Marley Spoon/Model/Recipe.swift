//
//  Recipe.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/5/21.
//

import Foundation
import Contentful

public final class Recipe: EntryDecodable, FieldKeysQueryable, Identifiable {

  public static let contentTypeId: String = "recipe"

  public let id: String
  public let localeCode: String?
  public let updatedAt: Date?
  public let createdAt: Date?

    public let title: String?
    public let description: String?
    public let calories: Int?

    // Linked fields
    public var chef: Chef?
    public var photo: Asset?
    public var tags: [Tag]?

    // for creating test objects
    public init(title: String, description: String, calories: Int, chef: Chef, tags: [Tag]) {
        self.title = title
        self.description = description
        self.calories = calories
        self.chef = chef
        self.tags = tags

        self.id = ""
        self.localeCode = "en-US"
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    // for creating mock object
    public init(id: String) {

        self.id = id

        self.title = "title"
        self.description = ""
        self.calories = 0
        self.chef = Chef(name: "")
        self.tags = [Tag(name: "")]
        self.localeCode = "en-US"
        self.createdAt = Date()
        self.updatedAt = Date()

    }

    public required init(from decoder: Decoder) throws {
        let sys = try decoder.sys()
        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: Recipe.FieldKeys.self)

        self.title = try fields.decodeIfPresent(String.self, forKey: .title)
        self.description = try fields.decodeIfPresent(String.self, forKey: .description)
        self.calories = try fields.decodeIfPresent(Int.self, forKey: .calories)

        try fields.resolveLink(forKey: .chef, decoder: decoder) { [weak self] linkedChef in
            self?.chef = linkedChef as? Chef
        }

        try fields.resolveLink(forKey: .photo, decoder: decoder) { [weak self] photo in
            self?.photo = photo as? Asset
        }

        try fields.resolveLinksArray(forKey: .tags, decoder: decoder) { [weak self] tags in
            self?.tags = tags as? [Tag]
        }
    }

    public enum FieldKeys: String, CodingKey {
        case title, description, tags, chef, photo, calories, name, id
    }

    func getAllRecipes(result : @escaping RecipesResult) {
        RecipeService.fetchRecipes { response in
            result(response)
        }
    }

}
