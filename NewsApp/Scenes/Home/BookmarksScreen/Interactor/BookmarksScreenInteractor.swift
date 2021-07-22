//
//  BookmarksScreenInteractor.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

import Foundation

class BookmarksScreenInteractor {
    
    // MARK: - VIPER Stack
    weak var presenter: BookmarksScreenInteractorToPresenterProtocol!
    
}

// MARK: - Presenter To Interactor Protocol
extension BookmarksScreenInteractor: BookmarksScreenPresenterToInteractorProtocol {
    func fetchAllBookmarks(){
       let bookmarks = CacheManager().fetchBookmarkedArticles()
       presenter?.fetchBookmarksSuccess(list: bookmarks ?? [])
    }
}
