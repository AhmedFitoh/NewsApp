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
}

// MARK: - View to Presenter Protocol
extension HeadLinesScreenPresenter: HeadLinesScreenViewToPresenterProtocol {
   
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
        headLinesDataSource = headLines
        view?.reloadHeadlinesTable()
    }
    
 
    func userSelected(category: String) {
        selectedCategory = category
        fetchHeadLines()
    }
    
    func userBookmarkedItem(atIndex index: Int) {
        
    }
  
    func userDidSelectArticle(atIndex index: Int) {
        wireframe?.navigateTo(url: headLines?.articles? [index].url)
    }
    
   
    func userTappedRefresh() {
        fetchHeadLines()
    }
    
    func viewDidFinishLoading() {
        interactor.fetchCategories()
    }
    
    
}
