//
//  Tag.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/5/21.
//

import Foundation
import Contentful

public final class Tag: EntryDecodable, FieldKeysQueryable {

  public static let contentTypeId: String = "tag"

  public let id: String
  public let localeCode: String?
  public let updatedAt: Date?
  public let createdAt: Date?

  public let name: String?

  // for creating test objects
  public init(name: String) {
    self.name = name
    self.id = ""
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

    let fields = try decoder.contentfulFieldsContainer(keyedBy: Tag.FieldKeys.self)

    self.name = try fields.decodeIfPresent(String.self, forKey: .name)
  }

  public enum FieldKeys: String, CodingKey {
    case name
  }
}
