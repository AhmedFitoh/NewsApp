//
//  Source+CoreDataProperties.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/21/21.
//
//

import Foundation
import CoreData


extension Source {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Source> {
        return NSFetchRequest<Source>(entityName: "Source")
    }

    @NSManaged public var name: String?
    @NSManaged public var article: Article?

}

extension Source : Identifiable {

}
