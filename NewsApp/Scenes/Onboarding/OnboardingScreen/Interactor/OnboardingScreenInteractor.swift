//
//  OnboardingScreenInteractor.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import Foundation

class OnboardingScreenInteractor {
    
    // MARK: - VIPER Stack
    weak var presenter: OnboardingScreenInteractorToPresenterProtocol!
    
}

// MARK: - Presenter To Interactor Protocol
extension OnboardingScreenInteractor: OnboardingScreenPresenterToInteractorProtocol {
   
    func setFirstOpenFlag(){
        UserDefaults.standard.set(true, forKey: "FirstRun")
    }
    
    func save(country: CountryModel) {
        UserDefaults.standard.set(country.isoCode, forKey: "CountryCode")
    }
    
    func save(categories: [String]) {
        UserDefaults.standard.setValue(categories, forKey: "Categories")
    }
    
    
    func fetchCountriesList() {
        let countriesList = Locale.isoRegionCodes.compactMap {
            CountryModel(name: Locale.current.localizedString(forRegionCode: $0), isoCode: $0)
        }
        presenter?.countriesListFetchSuccess(list: countriesList)
    }
    
    
    func fetchCategoriesList() {
        let list = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
        presenter?.categoriesListFetchSuccess(list: list)
    }
    
}
