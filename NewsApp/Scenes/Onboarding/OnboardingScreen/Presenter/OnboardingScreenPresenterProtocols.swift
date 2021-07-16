//
//  OnboardingScreenPresenterProtocols.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

// VIPER Protocol to the Module
protocol OnboardingScreenDelegate: AnyObject {
    
}

// VIPER Protocol for communication from Interactor -> Presenter
protocol OnboardingScreenInteractorToPresenterProtocol: AnyObject {
    func countriesListFetchSuccess(list: [CountryModel])
    func categoriesListFetchSuccess(list: [String])
}

// VIPER Protocol for communication from View -> Presenter
protocol OnboardingScreenViewToPresenterProtocol: AnyObject {
    var countriesList: [CountryModel] {get}
    var categoriesList: [String] {get}
    
    func viewDidFinishLoading()
    func userSelectedCountry(atIndex countryIndex: Int, categoriesWithIndex catIndices: [Int])
}
