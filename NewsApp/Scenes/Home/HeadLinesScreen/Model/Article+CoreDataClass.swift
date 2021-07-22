//
//  Article+CoreDataClass.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/21/21.
//
//

import Foundation
import CoreData


@objc(Article)
public class Article: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case source, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) else {
            throw  DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(entity: entity, insertInto: nil)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articleDescription = try container.decodeIfPresent(String.self, forKey: .articleDescription) ?? nil
        self.bookmarked = false
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? nil
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? nil
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? nil
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? nil
        self.source = try container.decodeIfPresent(Source.self, forKey: .source) ?? nil
    }
}
