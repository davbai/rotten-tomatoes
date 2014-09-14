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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movies"
        
        var path = NSBundle.mainBundle().pathForResource("Configuration", ofType: "plist")
        var config = NSDictionary(contentsOfFile: path!)
        
        let rottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + (config["RottenTomatoesAPI"] as String)
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(rottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
