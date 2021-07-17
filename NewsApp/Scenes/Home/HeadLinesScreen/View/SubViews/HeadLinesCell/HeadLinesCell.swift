//
//  HeadLinesCell.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/16/21.
//

import UIKit

class HeadLinesCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        articleImageView.image = UIImage(named: "LoadingIcon")
    }

    func setupCellWith(article: Article, indexPath: IndexPath){
        titleLabel.text = article.title
        descLabel.text = article.articleDescription
        sourceLabel.text = article.source?.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let dateString = article.publishedAt,
           let date = dateFormatter.date(from: dateString){
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateLabel.text = dateFormatter.string(from: date)
        }
            
        if let urlString = article.urlToImage {
            articleImageView.loadImageUsingCache(withUrl: urlString, cellIndexPathRow: indexPath.row, placeHolderImage: UIImage(named: "LoadingIcon"))

        }
    }
    
}
