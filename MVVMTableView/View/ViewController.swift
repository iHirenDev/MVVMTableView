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
        tblView.isHidden = true
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        // Call stopAnimating() when need to stop activity indicator
        
        
        
        view.addSubview(myActivityIndicator)
        view.bringSubview(toFront: myActivityIndicator)
        
        
        viewModel.fetchMovies { (success) -> Void in
            if(success){
                DispatchQueue.main.async {
                    myActivityIndicator.stopAnimating()
                    self.tblView.isHidden = false
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

