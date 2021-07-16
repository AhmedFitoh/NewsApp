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
    var headLines: HeadLineModel?
    // MARK: - Life Cycle
    init(wireframe: HeadLinesScreenPresenterToWireframeProtocol, view: HeadLinesScreenPresenterToViewProtocol, interactor: HeadLinesScreenPresenterToInteractorProtocol, delegate: HeadLinesScreenDelegate? = nil) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.view = view
        self.delegate = delegate
    }
    
    private func fetchHeadLines(){
        view?.adjustLoadingMode(to: true)
        interactor?.fetchHeadLines()
    }
}

// MARK: - Interactor to Presenter Protocol
extension HeadLinesScreenPresenter: HeadLinesScreenInteractorToPresenterProtocol {
    func fetchHeadLinesSuccess(headLines: HeadLineModel) {
        self.headLines = headLines
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
   
    func userBookmarkedItem(atIndex index: Int) {
        
    }
  
    func userDidSelectArticle(atIndex index: Int) {
        wireframe?.navigateTo(url: headLines?.articles? [index].url)
    }
    
   
    func userTappedRefresh() {
        fetchHeadLines()
    }
    
    func viewDidFinishLoading() {
        fetchHeadLines()
    }
    
    
}
