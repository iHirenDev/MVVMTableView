//
//  MovieModel.swift
//  MVVMTableView
//
//  Created by Hiren Patel on 10/9/18.
//  Copyright © 2018 com.hiren. All rights reserved.
//

import Foundation

struct MovieModel{
    var artistName:String?
    var id:Int?
    var releaseDate:String?
    var name:String?
    var kind:String?
    var copyright:String?
    var artworkURL:String?
    var genres:[Genres] = []
    var link:String?
    
    init(dictionary:NSDictionary) {
        self.artistName = dictionary["artistName"] as? String
        self.id = dictionary["id"] as? Int
        self.releaseDate = dictionary["releaseDate"] as? String
        self.name = dictionary["name"] as? String
        self.kind = dictionary["kind"] as? String
        self.copyright = dictionary["copyright"] as? String
        self.artworkURL = dictionary["artworkUrl100"] as? String
        self.link = dictionary["url"] as? String
    }
}

class Genres{
    var genreId:Int?
    var name:String?
    var genresUrl:String?
}

