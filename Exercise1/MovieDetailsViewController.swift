//
//  MovieDetailsViewController.swift
//  Exercise1
//
//  Created by Isaac Ho on 2/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//
import UIKit

class MovieDetailsViewController: UITableViewController {
    var movie: NSDictionary? = nil
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return( 1 )
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movieDetailsCell = tableView.dequeueReusableCellWithIdentifier("com.codepath.moviedetailscell")  as MovieDetailsCell
        
        // set the image
        let posters = movie!["posters"] as NSDictionary
        let thumbnailURL = posters["original"] as NSString
        if let myURL = NSURL(string:thumbnailURL) {
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
                dispatch_async(dispatch_get_main_queue()) {
                    println("loading poster")
                    movieDetailsCell.imgView.setImageWithURL(myURL)
                    println("done loading lo-res poster")
                    
                    dispatch_async(dispatch_get_main_queue()){
                        // load hi-res poster
                        let hiResURL = thumbnailURL.stringByReplacingOccurrencesOfString("_tmb", withString: "_ori")
                        let myURLHi = NSURL(string:hiResURL)?
                        movieDetailsCell.imgView.setImageWithURL(myURLHi)

                        println("done loading hi-res poster")
                    }
                }
            }
        }
        
        // set the title
        movieDetailsCell.titleLabel.text = movie!["title"] as NSString
        // set the scores
        var ratingsDict = movie!["ratings"] as NSDictionary
        var criticScore = ratingsDict["critics_score"] as Int
        var audienceScore = ratingsDict["audience_score"] as Int
        
        movieDetailsCell.scoresLabel.text = "Critic score: \(criticScore)     Audience score: \(audienceScore)"
        
        // set the synopsis
        movieDetailsCell.synopsisTextView.text = movie!["synopsis"] as NSString

        
        return movieDetailsCell
    }
    @IBAction func done(segue:UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clearColor()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
}
