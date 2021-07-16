//
//  ServiceHandler.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/16/21.
//

import Foundation

struct BaseUrls{
    fileprivate static let defaultURL = "https://newsapi.org/v2/"
}


enum NetworkAPIsConstants{
    case fetchHeadlines(countryCode: String, category: String)
}

extension NetworkAPIsConstants{
   fileprivate var path: String{
        switch self {
        case let .fetchHeadlines(countryCode, category):
            return  "top-headlines?country=\(countryCode)&category=\(category)"
        }
    }
    
    var httpMethod: String{
        switch self {
        case .fetchHeadlines:
            return "GET"
        }
    }
    
    var url: String{
        switch self {
        case .fetchHeadlines:
            return BaseUrls.defaultURL + path
        }
    }
}

