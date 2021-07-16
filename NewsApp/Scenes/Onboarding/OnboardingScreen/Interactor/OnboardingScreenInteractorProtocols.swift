//
//  OnboardingScreenInteractorProtocols.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

// VIPER Protocol for communication from Presenter to Interactor
protocol OnboardingScreenPresenterToInteractorProtocol: AnyObject {
    func fetchCountriesList()
    func fetchCategoriesList()
    func save(country: CountryModel)
    func save(categories: [String])
    func setFirstOpenFlag()
}
