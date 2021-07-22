//
//  HeadLinesScreenPresenterProtocols.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

// VIPER Protocol to the Module
protocol HeadLinesScreenDelegate: AnyObject {
    
}

// VIPER Protocol for communication from Interactor -> Presenter
protocol HeadLinesScreenInteractorToPresenterProtocol: AnyObject {
    func fetchHeadLinesSuccess(headLines: HeadLineModel)
    func fetchHeadLinesError(error: Error?)
    func fetchCategoriesSuccess(list: [String])
    func saveObjectError(error: Error)
}

// VIPER Protocol for communication from View -> Presenter
protocol HeadLinesScreenViewToPresenterProtocol: AnyObject {
    var headLinesDataSource: HeadLineModel? {get}
    var categories: [String] {get}
    func viewDidFinishLoading()
    func userTappedRefresh()
    func userSelected(category: String)
    func userDidSelectArticle(atIndex index: Int)
    func userSearchedFor(text searchItem: String?)
    func userCanceledSearch()
    func addItemToBookmarksAt(index: Int)
    func removeItemFromBookmarksAt(index: Int)
    func userTappedBookmarks()
}
