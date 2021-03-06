//
//  HeadLinesScreenInteractorProtocols.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

// VIPER Protocol for communication from Presenter to Interactor
protocol HeadLinesScreenPresenterToInteractorProtocol: AnyObject {
    func fetchHeadLines(forCategory category: String)
    func fetchCategories()
    func saveChanges(article: Article)
}
