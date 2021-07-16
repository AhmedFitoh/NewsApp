//
//  OnboardingScreenWireframe.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import UIKit

class OnboardingScreenWireframe {
    
    // MARK: - Instance Variables
    weak var viewController: UIViewController!
    // Uncomment to utilize a navigation contoller from storyboard
    // weak var navigationController: UINavigationController?
    
    // MARK:- Life cycle
    init(delegate: OnboardingScreenDelegate? = nil) {
        let storyboard = UIStoryboard(name: OnboardingScreenConstants.storyboardIdentifier, bundle: Bundle(for: OnboardingScreenWireframe.self))
        
        // Uncomment to utilize a navigation contoller from storyboard
        /*
        navigationController = storyboard.instantiateViewController(withIdentifier: OnboardingScreenConstants.navigationControllerIdentifier) as! UINavigationController
        let view = navigationController?.viewControllers[0] as! OnboardingScreenView
        */
        
        // Remove if used navigation controller from storyboard
        let view = (storyboard.instantiateViewController(withIdentifier: OnboardingScreenConstants.viewControllerIdentifier) as? OnboardingScreenView)!
        
        viewController = view
        
        let interactor = OnboardingScreenInteractor()
        let presenter = OnboardingScreenPresenter(wireframe: self, view: view, interactor: interactor, delegate: delegate)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: - Presenter to Wireframe Protocol
extension OnboardingScreenWireframe: OnboardingScreenPresenterToWireframeProtocol {
    
    
}
