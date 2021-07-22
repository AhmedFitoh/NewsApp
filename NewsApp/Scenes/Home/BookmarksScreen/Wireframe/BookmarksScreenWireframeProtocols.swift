//
//  BookmarksScreenWireframeProtocols.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

// VIPER Module Constants
struct BookmarksScreenConstants {
    
    // Uncomment to utilize a navigation contoller from storyboard
    // static let navigationControllerIdentifier = "BookmarksScreenNavigationController"
    
    static let storyboardIdentifier = "BookmarksScreen"
    static let viewControllerIdentifier = "BookmarksScreenView"
}

// VIPER Protocol for communication from Presenter -> Wireframe
protocol BookmarksScreenPresenterToWireframeProtocol: AnyObject {
    func navigateTo(url: String?)
    
}
