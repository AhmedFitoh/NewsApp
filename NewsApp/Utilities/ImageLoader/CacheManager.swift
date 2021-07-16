//
//  CacheManager.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/16/21.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    let imageCacher: NSCache<NSString, UIImage>
    private init() {
        self.imageCacher = NSCache<NSString, UIImage>()
    }
}
