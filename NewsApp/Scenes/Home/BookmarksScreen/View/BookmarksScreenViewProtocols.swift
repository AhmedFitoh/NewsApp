//
//  BookmarksScreenViewProtocols.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

// VIPER Protocol for communication from Presenter -> View
protocol BookmarksScreenPresenterToViewProtocol: AnyObject {
    func refreshBookmarksTable()
}
