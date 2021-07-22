//
//  CacheManager.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/21/21.
//

import CoreData
import UIKit

class CacheManager {
    
    static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    func fetchAllArticles () -> [Article]? {
        let context = CacheManager.persistentContainer.viewContext
        if let articles = try? context.fetch(Article.createFetchRequest()) {
            return articles
        } else {
            return nil
        }
    }
    
    func fetchBookmarkedArticles () -> [Article]? {
        let context = CacheManager.persistentContainer.viewContext
        let fetchRequest = Article.createFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "bookmarked = %@", "1")
        if let articles = try? context.fetch(fetchRequest) {
            return articles
        } else {
            return nil
        }
    }
    
    func deleteAllArticles() throws {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Article.fetchRequest())
        do {
            try CacheManager.persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            throw error
        }
    }
    
    func deleteArticle (_ info: Article) throws {
        CacheManager.persistentContainer.viewContext.delete(info)
        do {
            try CacheManager.persistentContainer.viewContext.save()
        } catch {
            throw error
        }
    }
    
    func save(data: NSManagedObject) throws {
        let context = CacheManager.persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let _ =  data.copyEntireObjectGraph(context: context)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
        context.reset()
    }

}
