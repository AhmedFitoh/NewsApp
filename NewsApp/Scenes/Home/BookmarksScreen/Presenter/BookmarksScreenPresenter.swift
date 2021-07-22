//
//  BookmarksScreenPresenter.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

import Foundation

class BookmarksScreenPresenter {
    
    // MARK: - VIPER Stack
    weak var view: BookmarksScreenPresenterToViewProtocol!
    var interactor: BookmarksScreenPresenterToInteractorProtocol!
    var wireframe: BookmarksScreenPresenterToWireframeProtocol!
    
    // MARK: - Instance Variables
    weak var delegate: BookmarksScreenDelegate?
    var bookmarksList: [Article] = []
    // MARK: - Life Cycle
    init(wireframe: BookmarksScreenPresenterToWireframeProtocol, view: BookmarksScreenPresenterToViewProtocol, interactor: BookmarksScreenPresenterToInteractorProtocol, delegate: BookmarksScreenDelegate? = nil) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.view = view
        self.delegate = delegate
    }
}

// MARK: - Interactor to Presenter Protocol
extension BookmarksScreenPresenter: BookmarksScreenInteractorToPresenterProtocol {
    
    func fetchBookmarksSuccess(list: [Article]) {
        bookmarksList = list
        view?.refreshBookmarksTable()
    }

}

// MARK: - View to Presenter Protocol
extension BookmarksScreenPresenter: BookmarksScreenViewToPresenterProtocol {
  
    func viewDidFinishLoading() {
        interactor?.fetchAllBookmarks()
    }
    
    func userDidSelectArticle(atIndex index: Int) {
        wireframe?.navigateTo(url: bookmarksList [index].url)
    }
    
}
