//
//  APIClient.swift
//  MVVMTableView
//
//  Created by Hiren Patel on 10/9/18.
//  Copyright © 2018 com.hiren. All rights reserved.
//

import Foundation

class APIClient: NSObject {
    func apiCall(completion: @escaping ([NSDictionary]?) -> Void){
        
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/au/movies/top-movies/all/50/explicit.json") else {
            print("Error unwrapping URL"); return }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                if let data = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary{
                    if let movies = data.value(forKeyPath: "feed.results") as? [NSDictionary]{
                        completion(movies)
                    }
                }
                
            } catch {
                completion(nil)
                print("json error: \(error)")
            }
        }
        task.resume()
    }
}


