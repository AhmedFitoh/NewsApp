//
//  HeadLinesScreenView.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import UIKit

class HeadLinesScreenView: UIViewController {
    @IBOutlet weak var headLineTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // MARK: - VIPER Stack
    var presenter: HeadLinesScreenViewToPresenterProtocol!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidFinishLoading()
    }
    
    private func setupUI(){
        setupHeadLineTableView()
        setupNavigationController()
    }
    
    private func setupNavigationController(){
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupHeadLineTableView(){
        headLineTableView.tableFooterView = UIView()
        headLineTableView.register(UINib(nibName: "\(HeadLinesCell.self)", bundle: nil),
                                   forCellReuseIdentifier: "\(HeadLinesCell.self)")
    }
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        presenter?.userTappedRefresh()
    }
}

// MARK: - TableView delegates
extension HeadLinesScreenView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.headLines?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HeadLinesCell.self)") as? HeadLinesCell
        if let article = presenter?.headLines?.articles? [indexPath.row]{
            cell?.setupCellWith(article: article, indexPath: indexPath)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.userDidSelectArticle(atIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bookmark = UIContextualAction(style: .normal,
                                          title: "Bookmark") { [weak self] (action, view, completionHandler) in
            self?.presenter?.userBookmarkedItem(atIndex: indexPath.row)
            completionHandler(true)
        }
        bookmark.backgroundColor = .systemOrange
        let configuration = UISwipeActionsConfiguration(actions: [bookmark])
        return configuration
    }
    
    
}

// MARK: - Presenter to View Protocol
extension HeadLinesScreenView: HeadLinesScreenPresenterToViewProtocol {
    func reloadHeadlinesTable() {
        headLineTableView.reloadData()
    }
    
    
    func adjustLoadingMode(to isLoading: Bool){
        refreshButton.isEnabled = !isLoading
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        headLineTableView.isUserInteractionEnabled = !isLoading
        headLineTableView.alpha = isLoading ? 0.2 : 1
    }
    
}
