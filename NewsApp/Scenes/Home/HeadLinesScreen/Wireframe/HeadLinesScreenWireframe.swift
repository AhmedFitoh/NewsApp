//
//  HeadLinesScreenWireframe.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import UIKit

class HeadLinesScreenWireframe {
    
    // MARK: - Instance Variables
    weak var viewController: UIViewController!
    // Uncomment to utilize a navigation contoller from storyboard
     weak var navigationController: UINavigationController?
    
    // MARK:- Life cycle
    init(delegate: HeadLinesScreenDelegate? = nil) {
        let storyboard = UIStoryboard(name: HeadLinesScreenConstants.storyboardIdentifier, bundle: Bundle(for: HeadLinesScreenWireframe.self))
        
        // Uncomment to utilize a navigation contoller from storyboard
    
        navigationController = storyboard.instantiateViewController(withIdentifier: HeadLinesScreenConstants.navigationControllerIdentifier) as? UINavigationController
        let view = navigationController?.viewControllers[0] as! HeadLinesScreenView
        
        
        // Remove if used navigation controller from storyboard
//        let view = (storyboard.instantiateViewController(withIdentifier: HeadLinesScreenConstants.viewControllerIdentifier) as? HeadLinesScreenView)!
//
        viewController = view
        
        let interactor = HeadLinesScreenInteractor()
        let presenter = HeadLinesScreenPresenter(wireframe: self, view: view, interactor: interactor, delegate: delegate)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: - Presenter to Wireframe Protocol
extension HeadLinesScreenWireframe: HeadLinesScreenPresenterToWireframeProtocol {
   
    func openBookmarksScreen() {
        viewController?.navigationController?.pushViewController(BookmarksScreenWireframe().viewController, animated: true)
    }
    
    func navigateTo(url: String?) {
        guard let encodedUrl = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            print("Invalid URL:\n\(String(describing: url))")
            return
        }
        UIApplication.shared.open(url)
    }
    
}
