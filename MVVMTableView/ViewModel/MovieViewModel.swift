//
//  MovieViewModel.swift
//  MVVMTableView
//
//  Created by Hiren Patel on 10/9/18.
//  Copyright © 2018 com.hiren. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel:NSObject {
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    var apiClient = APIClient()
    var topMovies:[NSDictionary] = []
    var movie:[MovieModel] = []
    override init() {
        super.init()
    }
    
    func fetchMovies(completion:@escaping CompletionHandler) {
        apiClient.apiCall { (movieDict) in
            self.topMovies = movieDict! as [NSDictionary]
            self.movie = self.movieArray(array: self.topMovies)
            completion(true)
        }
    }
    
    func movieArray(array:[NSDictionary]) -> [MovieModel]{
        for item in array
        {
            movie.append(MovieModel.init(dictionary:item))
        }
        return movie
    }
    
    func numberOfRows() -> Int {
        return movie.count
    }
    
    
}

