//
//  Article+CoreDataProperties.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/21/21.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var articleDescription: String?
    @NSManaged public var bookmarked: Bool
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var source: Source?

}

extension Article : Identifiable {

}
