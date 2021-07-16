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
}

// VIPER Protocol for communication from View -> Presenter
protocol HeadLinesScreenViewToPresenterProtocol: AnyObject {
    var headLines: HeadLineModel? {get}
    func viewDidFinishLoading()
    func userTappedRefresh()
    func userDidSelectArticle(atIndex index: Int)
    func userBookmarkedItem(atIndex index: Int)
}
