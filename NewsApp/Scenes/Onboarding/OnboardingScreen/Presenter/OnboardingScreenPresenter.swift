//
//  OnboardingScreenPresenter.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import Foundation

class OnboardingScreenPresenter {
    
    // MARK: - VIPER Stack
    weak var view: OnboardingScreenPresenterToViewProtocol!
    var interactor: OnboardingScreenPresenterToInteractorProtocol!
    var wireframe: OnboardingScreenPresenterToWireframeProtocol!
    
    // MARK: - Instance Variables
    weak var delegate: OnboardingScreenDelegate?
    var countriesList: [CountryModel] = []
    var categoriesList: [String] = []
    
    var fetchDataDispatchGroup = DispatchGroup()
    
    // MARK: - Life Cycle
    init(wireframe: OnboardingScreenPresenterToWireframeProtocol, view: OnboardingScreenPresenterToViewProtocol, interactor: OnboardingScreenPresenterToInteractorProtocol, delegate: OnboardingScreenDelegate? = nil) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.view = view
        self.delegate = delegate
    }
    
    private func setupFetchDataDispatchGroup(){
        fetchDataDispatchGroup.notify(queue: .main, execute: { [weak view] in
            view?.reloadInfoViews()
        })
    }
    private func fetchData(){
        fetchDataDispatchGroup.enter()
        fetchDataDispatchGroup.enter()
        interactor?.fetchCategoriesList()
        interactor?.fetchCountriesList()
    }
    
    
}

// MARK: - Interactor to Presenter Protocol
extension OnboardingScreenPresenter: OnboardingScreenInteractorToPresenterProtocol {
    func categoriesListFetchSuccess(list: [String]) {
        categoriesList = list
        fetchDataDispatchGroup.leave()
    }
    
    func countriesListFetchSuccess(list: [CountryModel]) {
        countriesList = list
        fetchDataDispatchGroup.leave()
    }
    
    
}

// MARK: - View to Presenter Protocol
extension OnboardingScreenPresenter: OnboardingScreenViewToPresenterProtocol {
   
    func userSelectedCountry(atIndex countryIndex: Int, categoriesWithIndex catIndices: [Int]) {
        var categories: [String] = []
        catIndices.forEach {
            categories.append(categoriesList [$0])
        }
        interactor?.save(categories: categories)
        interactor?.save(country: countriesList [countryIndex])
        interactor?.setFirstOpenFlag()
        wireframe?.navigateToHeadlines()
    }
    
    func viewDidFinishLoading() {
        setupFetchDataDispatchGroup()
        fetchData()
    }
    
  
    
}
