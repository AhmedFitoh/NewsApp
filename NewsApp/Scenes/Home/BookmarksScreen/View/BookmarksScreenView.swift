//
//  BookmarksScreenView.swift
//
//  Created by AhmedFitoh on 7/22/21.
//  
//

import UIKit

class BookmarksScreenView: UIViewController {
    
    @IBOutlet weak var bookmarksTableView: UITableView!
    
    // MARK: - VIPER Stack
    var presenter: BookmarksScreenViewToPresenterProtocol!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidFinishLoading()
    }
    
    private func setupUI(){
        setupBookmarksTableView()
    }
    
    private func setupBookmarksTableView(){
        bookmarksTableView.tableFooterView = UIView()
        bookmarksTableView.register(UINib(nibName: "\(BookmarksCell.self)", bundle: nil),
                                   forCellReuseIdentifier: "\(BookmarksCell.self)")
    }
}

// MARK: - TableView delegates
extension BookmarksScreenView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.bookmarksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookmarksCell.self)") as? BookmarksCell
        if let article = presenter?.bookmarksList [indexPath.row]{
            cell?.setupCellWith(article: article, indexPath: indexPath)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.userDidSelectArticle(atIndex: indexPath.row)
    }
    
}

// MARK: - Presenter to View Protocol
extension BookmarksScreenView: BookmarksScreenPresenterToViewProtocol {
    
    func refreshBookmarksTable(){
        bookmarksTableView.reloadData()
    }
}
