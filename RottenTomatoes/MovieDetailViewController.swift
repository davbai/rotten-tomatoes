//
//  MovieDetailViewController.swift
//  RottenTomatoes
//
//  Created by David Bai on 9/14/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterBackground: UIImageView!
    
    var movie : NSDictionary = [NSObject: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set low-res photo
        var posters = movie["posters"] as NSDictionary
        var thumbnailURL = posters["thumbnail"] as String
        posterBackground.setImageWithURL(NSURL(string: thumbnailURL))

//        http://api.rottentomatoes.com/api/public/v1.0/movies/770672122.json?apikey=[your_api_key]
    }

}
