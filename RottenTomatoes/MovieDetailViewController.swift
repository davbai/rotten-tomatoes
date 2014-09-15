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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = movie["title"] as? String
        
        // Set low-res photo
        var posters = movie["posters"] as NSDictionary
        let thumbnailURL = posters["thumbnail"] as String
        posterBackground.setImageWithURL(NSURL(string: thumbnailURL))

        // Set movie details
        titleLabel.text = movie["title"] as? String
        
        var ratings = movie["ratings"] as NSDictionary
        var criticsScore = ratings["critics_score"] as NSInteger
        var audienceScore = ratings["audience_score"] as NSInteger
        reviewLabel.text = "Critics Score: " + String(criticsScore) + " Audience Score: " + String(audienceScore)
        
        ratingLabel.text = movie["mpaa_rating"] as? String
        
        synopsis.text = movie["synopsis"] as? String
        synopsis.sizeToFit()
        detailsView.frame.size.height = synopsis.frame.height + titleLabel.frame.height + reviewLabel.frame.height + ratingLabel.frame.height + 16 // padding
        
        scrollView.contentSize = CGSize(width: detailsView.frame.width, height: detailsView.frame.height + 252)
        
        let fullResURL = thumbnailURL.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        posterBackground.setImageWithURL(NSURL(string: fullResURL))
        
    }

}
