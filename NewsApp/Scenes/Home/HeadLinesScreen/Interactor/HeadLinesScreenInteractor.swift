//
//  HeadLinesScreenInteractor.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import Foundation

class HeadLinesScreenInteractor {
    
    // MARK: - VIPER Stack
    weak var presenter: HeadLinesScreenInteractorToPresenterProtocol!
    var webService: WebService!
    init(webService: WebService = WebService()) {
        self.webService = webService
    }
    private func fetchDefaultCountryCode() -> String {
        return UserDefaults.standard.string(forKey: "CountryCode") ?? ""
    }
    
  
}


// MARK: - Presenter To Interactor Protocol
extension HeadLinesScreenInteractor: HeadLinesScreenPresenterToInteractorProtocol {
    
    func fetchCategories() {
        presenter?.fetchCategoriesSuccess(list: UserDefaults.standard.stringArray(forKey: "Categories") ?? [])
    }
    
    func fetchHeadLines(forCategory category: String){
        webService.request(.fetchHeadlines(countryCode: fetchDefaultCountryCode(), category: category)) {[weak presenter] data in
            guard let data = data else {
                return
            }
            
            do {
                let headLines = try JSONDecoder().decode(HeadLineModel.self, from: data)
                presenter?.fetchHeadLinesSuccess(headLines: headLines)
            } catch {
                presenter?.fetchHeadLinesError(error: error)
            }
        } failure: {[weak presenter] error in
            presenter?.fetchHeadLinesError(error: error)
        }
    }

    
}
