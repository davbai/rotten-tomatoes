//
//  MovieTableViewController.swift
//  RottenTomatoes
//
//  Created by David Bai on 9/12/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    var movies : [NSDictionary] = []
    
    var networkErrorView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movies"
        
        // Set up colors
        self.tableView.backgroundColor = UIColor.blackColor()
        
        // Set up network error view
        networkErrorView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        networkErrorView.backgroundColor = UIColor.lightGrayColor()
        
        var errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        errorLabel.text = "Network Error"
        errorLabel.textAlignment = NSTextAlignment.Center
        
        networkErrorView.addSubview(errorLabel)

        // Support for pull-to-refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        
        refresh()
    }

    func refresh() {
        let loadingView = GKPopLoadingView()
        loadingView.show(true, withTitle: "Loading")
        
        var path = NSBundle.mainBundle().pathForResource("Configuration", ofType: "plist")
        var config = NSDictionary(contentsOfFile: path!)
        let rottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + (config["RottenTomatoesAPI"] as String)
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(rottenTomatoesURLString))
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            if error == nil {
                var errorValue: NSError? = nil
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.movies = dictionary["movies"] as [NSDictionary]
                self.tableView.reloadData()
                self.networkErrorView.removeFromSuperview()
            } else {
                self.view.addSubview(self.networkErrorView)
            }
            
            loadingView.show(false, withTitle: "")
            self.refreshControl?.endRefreshing()
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as MovieTableViewCell
        
        var movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        
        var rating = movie["mpaa_rating"] as String
        var synopsis = movie["synopsis"] as String
        cell.synopsisLabel.text = rating + " " + synopsis
        
        var posters = movie["posters"] as NSDictionary
        var thumbnailURL = posters["thumbnail"] as String
        
        cell.thumbnail.setImageWithURL(NSURL(string: thumbnailURL))

        return cell
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "movieSegue" {
            let movieDetailVC = segue.destinationViewController as MovieDetailViewController
            let selectedIndexPath = self.tableView.indexPathForCell(sender as UITableViewCell)
            movieDetailVC.movie = movies[selectedIndexPath!.row]
        }
    }


}
