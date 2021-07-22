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
    
    private func injectBookmarkStatus(headLines: HeadLineModel){
        if let bookmarkedArticles = CacheManager().fetchBookmarkedArticles(),
           !bookmarkedArticles.isEmpty {
            let bookmarkDictionary = Dictionary(uniqueKeysWithValues: bookmarkedArticles.map{ ($0.url , true)})
            for (index, element) in (headLines.articles ?? []).enumerated(){
                if bookmarkDictionary [element.url] != nil {
                    headLines.articles? [index].bookmarked = true
                }
            }
            presenter?.fetchHeadLinesSuccess(headLines: headLines)
        } else {
            presenter?.fetchHeadLinesSuccess(headLines: headLines)
        }
    }
  
}


// MARK: - Presenter To Interactor Protocol
extension HeadLinesScreenInteractor: HeadLinesScreenPresenterToInteractorProtocol {
  
    func saveChanges(article: Article) {
        do {
            try CacheManager().save(data: article)
        } catch {
            presenter?.saveObjectError(error: error)
        }
    }
    
    func fetchCategories() {
        presenter?.fetchCategoriesSuccess(list: UserDefaults.standard.stringArray(forKey: "Categories") ?? [])
    }
    
    func fetchHeadLines(forCategory category: String){
        webService.request(.fetchHeadlines(countryCode: fetchDefaultCountryCode(), category: category)) {[weak self] data in
            guard let data = data else {
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.userInfo [.managedObjectContext] = CacheManager.persistentContainer.newBackgroundContext()
            do {
                let headLines = try jsonDecoder.decode(HeadLineModel.self, from: data)
                self?.injectBookmarkStatus(headLines: headLines)
            } catch {
                self?.presenter?.fetchHeadLinesError(error: error)
            }
            
        } failure: {[weak presenter] error in
            presenter?.fetchHeadLinesError(error: error)
        }
    }

    
}
