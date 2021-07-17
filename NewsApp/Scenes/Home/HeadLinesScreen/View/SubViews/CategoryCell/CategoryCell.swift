//
//  CategoryCell.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/17/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
  
    override func prepareForReuse() {
        categoryLabel.font = UIFont.systemFont(ofSize: 17)
    }
}
