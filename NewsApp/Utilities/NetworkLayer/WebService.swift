//
//  WebService.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/16/21.
//

import Foundation

class WebService {
    // TODO:- add support to http body when needed
    func request(_ api: NetworkAPIsConstants,
                 completion: @escaping (Data?)-> Void,
                 failure: @escaping (Error?)-> Void){
        guard let url = URL(string: api.url) else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.httpMethod
        urlRequest.setValue(Constants.APIKey, forHTTPHeaderField: "X-Api-Key")
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            // Return to the main thread
            DispatchQueue.main.async {
                if let error = error{
                    failure(error)
                } else if let data = data{
                    completion(data)
                }
            }
        }.resume()
        
    }
}
