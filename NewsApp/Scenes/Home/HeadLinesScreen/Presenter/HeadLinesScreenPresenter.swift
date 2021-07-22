//
//  HeadLinesScreenPresenter.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import Foundation

class HeadLinesScreenPresenter {
    
    // MARK: - VIPER Stack
    weak var view: HeadLinesScreenPresenterToViewProtocol!
    var interactor: HeadLinesScreenPresenterToInteractorProtocol!
    var wireframe: HeadLinesScreenPresenterToWireframeProtocol!
    
    // MARK: - Instance Variables
    weak var delegate: HeadLinesScreenDelegate?
    var headLinesDataSource: HeadLineModel?
    var headLines: HeadLineModel?
    var categories: [String] = []
    var selectedCategory = ""
    var searchText: String?
    
    // MARK: - Life Cycle
    init(wireframe: HeadLinesScreenPresenterToWireframeProtocol, view: HeadLinesScreenPresenterToViewProtocol, interactor: HeadLinesScreenPresenterToInteractorProtocol, delegate: HeadLinesScreenDelegate? = nil) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.view = view
        self.delegate = delegate
    }
    
    private func fetchHeadLines(){
        view?.adjustLoadingMode(to: true)
        interactor?.fetchHeadLines(forCategory: selectedCategory)
    }
}

// MARK: - Interactor to Presenter Protocol
extension HeadLinesScreenPresenter: HeadLinesScreenInteractorToPresenterProtocol {
   
    func saveObjectError(error: Error) {
        //Log error to our server
        view?.showAlert(message: "An error has been occurred\nPlease try again", completionHandler: nil)
    }
    
   
    func fetchCategoriesSuccess(list: [String]) {
        categories = list
        view.reloadCategoriesCollectionView()
    }
    
    func fetchHeadLinesSuccess(headLines: HeadLineModel) {
        self.headLines = headLines
        userSearchedFor(text: searchText)
        view?.reloadHeadlinesTable()
        view?.adjustLoadingMode(to: false)
    }
    
    func fetchHeadLinesError(error: Error?) {
        view?.showAlert(message: error?.localizedDescription ?? "", completionHandler: nil)
        view?.adjustLoadingMode(to: false)
    }
    private func changeBookmarkOf(index: Int, to bookmark:Bool){
        headLinesDataSource?.articles? [index].bookmarked = bookmark
        let articleUrl =  headLinesDataSource?.articles? [index].url
        if let index = headLines?.articles?.firstIndex(where: { $0.url == articleUrl}) {
            headLines?.articles? [index].bookmarked = bookmark
        }
        if let article = headLinesDataSource?.articles? [index] {
            interactor?.saveChanges(article: article)
        }
    }
}

// MARK: - View to Presenter Protocol
extension HeadLinesScreenPresenter: HeadLinesScreenViewToPresenterProtocol {
  
    func userTappedBookmarks() {
        wireframe?.openBookmarksScreen()
    }
    
    func addItemToBookmarksAt(index: Int) {
        changeBookmarkOf(index: index, to: true)
    }
    
    func removeItemFromBookmarksAt(index: Int) {
        changeBookmarkOf(index: index, to: false)
    }
   
    func userSearchedFor(text searchItem: String?) {
        searchText = searchItem
        if let searchText = searchText,
           !searchText.isEmpty {
            //Search Active
            headLinesDataSource?.articles = headLines?.articles?.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false}
        } else {
            // Search Inactive
            headLinesDataSource = headLines
        }
        view?.reloadHeadlinesTable()
    }
    
    func userCanceledSearch() {
        searchText = nil
        headLinesDataSource = headLines
        view?.reloadHeadlinesTable()
    }
    
 
    func userSelected(category: String) {
        selectedCategory = category
        fetchHeadLines()
    }
    
  
    func userDidSelectArticle(atIndex index: Int){
        wireframe?.navigateTo(url: headLines?.articles? [index].url)
    }
    
   
    func userTappedRefresh() {
        fetchHeadLines()
    }
    
    func viewDidFinishLoading() {
        interactor.fetchCategories()
    }
    
    
}
