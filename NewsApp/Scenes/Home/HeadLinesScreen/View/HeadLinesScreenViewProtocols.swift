//
//  HeadLinesScreenViewProtocols.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

// VIPER Protocol for communication from Presenter -> View
protocol HeadLinesScreenPresenterToViewProtocol: AnyObject, Alertable {
    func reloadHeadlinesTable()
    func reloadCategoriesCollectionView()
    func adjustLoadingMode(to isLoading: Bool)
}
