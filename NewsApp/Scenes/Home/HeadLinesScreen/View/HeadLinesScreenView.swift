//
//  HeadLinesScreenView.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import UIKit

class HeadLinesScreenView: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
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
        setupCategoryViewCollection()
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
    
    private func setupCategoryViewCollection(){
        categoryCollectionView.register(UINib(nibName: "\(CategoryCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryCell.self)")
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

// MARK: - UICollectionView delegates
extension HeadLinesScreenView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell
        cell?.categoryLabel.text = presenter?.categories [indexPath.row]
        if ((collectionView.indexPathsForSelectedItems?.contains(indexPath)) == true) {
            cell?.categoryLabel.textColor = .orange
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
        cell?.categoryLabel.textColor = .orange
        presenter?.userSelected(category: presenter?.categories [indexPath.row] ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
        cell?.categoryLabel.textColor = .label
    }
    
}


// MARK: - Presenter to View Protocol
extension HeadLinesScreenView: HeadLinesScreenPresenterToViewProtocol {
   
    func reloadCategoriesCollectionView() {
        categoryCollectionView.reloadData()
        if !presenter.categories.isEmpty {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            categoryCollectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: .left)
            collectionView(categoryCollectionView, didSelectItemAt: firstIndexPath)
        }
    }
    
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
