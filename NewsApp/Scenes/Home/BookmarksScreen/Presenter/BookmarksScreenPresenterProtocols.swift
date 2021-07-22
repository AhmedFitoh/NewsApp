//
//  BookmarksScreenPresenterProtocols.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

// VIPER Protocol to the Module
protocol BookmarksScreenDelegate: AnyObject {
    
}

// VIPER Protocol for communication from Interactor -> Presenter
protocol BookmarksScreenInteractorToPresenterProtocol: AnyObject {
    func fetchBookmarksSuccess(list: [Article])
}

// VIPER Protocol for communication from View -> Presenter
protocol BookmarksScreenViewToPresenterProtocol: AnyObject {
    var bookmarksList: [Article] {get}
    func viewDidFinishLoading()
    func userDidSelectArticle(atIndex index: Int)
}
