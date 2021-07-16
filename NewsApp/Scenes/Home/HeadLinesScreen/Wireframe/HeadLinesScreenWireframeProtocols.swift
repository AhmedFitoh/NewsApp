//
//  HeadLinesScreenWireframeProtocols.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

// VIPER Module Constants
struct HeadLinesScreenConstants {
    
    // Uncomment to utilize a navigation contoller from storyboard
     static let navigationControllerIdentifier = "HeadLinesScreenNavigationController"
    
    static let storyboardIdentifier = "HeadLinesScreen"
//    static let viewControllerIdentifier = "HeadLinesScreenView"
}

// VIPER Protocol for communication from Presenter -> Wireframe
protocol HeadLinesScreenPresenterToWireframeProtocol: AnyObject {
    func navigateTo(url: String?)
}
