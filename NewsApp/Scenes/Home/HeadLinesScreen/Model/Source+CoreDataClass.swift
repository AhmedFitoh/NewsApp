//
//  Source+CoreDataClass.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/21/21.
//
//

import Foundation
import CoreData

@objc(Source)
public class Source: NSManagedObject, Decodable{
    
    enum CodingKeys: String, CodingKey {
        case name
        case article
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Source", in: context) else {
            throw  DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(entity: entity, insertInto: nil)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.article = try container.decodeIfPresent(Article.self, forKey: .article) ?? nil
    }
    
}



