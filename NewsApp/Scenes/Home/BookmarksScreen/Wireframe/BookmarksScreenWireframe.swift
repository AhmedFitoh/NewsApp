//
//  BookmarksScreenWireframe.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

import UIKit

class BookmarksScreenWireframe {
    
    // MARK: - Instance Variables
    weak var viewController: UIViewController!
    // Uncomment to utilize a navigation contoller from storyboard
    // weak var navigationController: UINavigationController?
    
    // MARK:- Life cycle
    init(delegate: BookmarksScreenDelegate? = nil) {
        let storyboard = UIStoryboard(name: BookmarksScreenConstants.storyboardIdentifier, bundle: Bundle(for: BookmarksScreenWireframe.self))
        
        // Uncomment to utilize a navigation contoller from storyboard
        /*
         navigationController = storyboard.instantiateViewController(withIdentifier: BookmarksScreenConstants.navigationControllerIdentifier) as! UINavigationController
         let view = navigationController?.viewControllers[0] as! BookmarksScreenView
         */
        
        // Remove if used navigation controller from storyboard
        let view = (storyboard.instantiateViewController(withIdentifier: BookmarksScreenConstants.viewControllerIdentifier) as? BookmarksScreenView)!
        
        viewController = view
        
        let interactor = BookmarksScreenInteractor()
        let presenter = BookmarksScreenPresenter(wireframe: self, view: view, interactor: interactor, delegate: delegate)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: - Presenter to Wireframe Protocol
extension BookmarksScreenWireframe: BookmarksScreenPresenterToWireframeProtocol {
    
    func navigateTo(url: String?) {
        guard let encodedUrl = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            print("Invalid URL:\n\(String(describing: url))")
            return
        }
        UIApplication.shared.open(url)
    }
}
