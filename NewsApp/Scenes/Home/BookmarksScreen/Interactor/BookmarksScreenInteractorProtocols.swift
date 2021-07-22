//
//  BookmarksScreenInteractorProtocols.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

// VIPER Protocol for communication from Presenter to Interactor
protocol BookmarksScreenPresenterToInteractorProtocol: AnyObject {
    func fetchAllBookmarks()
}
