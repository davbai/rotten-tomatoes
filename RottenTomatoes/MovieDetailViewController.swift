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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsis: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set low-res photo
        var posters = movie["posters"] as NSDictionary
        var thumbnailURL = posters["thumbnail"] as String
        posterBackground.setImageWithURL(NSURL(string: thumbnailURL))

        titleLabel.text = movie["title"] as? String
        
        var ratings = movie["ratings"] as NSDictionary
        var criticsScore = ratings["critics_score"] as NSInteger
        var audienceScore = ratings["audience_score"] as NSInteger
        reviewLabel.text = "Critics Score: " + String(criticsScore) + " Audience Score: " + String(audienceScore)
        
        ratingLabel.text = movie["mpaa_rating"] as? String
        
        synopsis.text = movie["synopsis"] as? String
    }

}
