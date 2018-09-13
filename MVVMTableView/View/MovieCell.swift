//
//  MovieCell.swift
//  MVVMTableView
//
//  Created by Hiren Patel on 10/9/18.
//  Copyright © 2018 com.hiren. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var director:UILabel!
    @IBOutlet weak var date:UILabel!
    @IBOutlet weak var movieImage:UIImageView!

    
    func movieData(movie:MovieModel){
        self.name.text = movie.name
        self.director.text = "Directed By:\(movie.artistName ?? "")"
        self.date.text = "Released On:\(movie.releaseDate ?? "")"
        
        self.movieImage.layer.borderWidth = 1
        self.movieImage.layer.masksToBounds = false
        self.movieImage.layer.borderColor = UIColor.black.cgColor
        self.movieImage.layer.cornerRadius = self.movieImage.frame.height/2
        self.movieImage.clipsToBounds = true
        
        self.movieImage.image = UIImage(named: "movie")
        let imgURL = URL(string: movie.artworkURL!)
        self.movieImage.downloaded(from: imgURL!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
