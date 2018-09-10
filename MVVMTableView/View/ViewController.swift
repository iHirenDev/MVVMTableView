//
//  ViewController.swift
//  MVVMTableView
//
//  Created by Hiren Patel on 10/9/18.
//  Copyright © 2018 com.hiren. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView:UITableView!
    
    var viewModel = MovieViewModel()
    var movieArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = 100
        
        viewModel.fetchMovies { (success) -> Void in
            if(success){
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
            else{
                print("Could not fetch the movies...")
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        let movie = viewModel.movie[indexPath.row]
        cell.movieData(movie: movie)
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = viewModel.movie[indexPath.row]
        
        guard let url = URL(string: movie.link!) else { return }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

