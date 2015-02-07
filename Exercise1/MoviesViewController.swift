//
//  MoviesViewController.swift
//  Exercise1
//
//  Created by Isaac Ho on 2/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    var rc: UIRefreshControl?
    var movies: NSArray?
    @IBOutlet weak var errorView: UIView!

    // factory for cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.moviecell") as MovieCell
        let movie = self.movies![indexPath.row] as NSDictionary
        let title = movie["title"] as NSString
        cell.label.text = title
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let posters = movie["posters"] as NSDictionary
        let thumbnailURL = posters["original"] as NSString
        if let myURL = NSURL(string:thumbnailURL) {
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
                dispatch_async(dispatch_get_main_queue()) {
                    let data = NSData(contentsOfURL: myURL)
                    cell.imgView.setImageWithURL(myURL)
                    
                    
                }
            }
        }
        
        return cell
    }
    
    // provide row count
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies != nil {
            return movies!.count
        }
        return 0
    }
    
    /*
    // on row selection...
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        for ( var i = 0; i < self.tableView.numberOfRowsInSection(0); i++ )
        {
            
            let myIndexPath = NSIndexPath( forRow:i, inSection:0 )
            let cell = self.tableView.cellForRowAtIndexPath(myIndexPath)
            
            if ( indexPath.row != i )
            {
                UIView.beginAnimations(nil,context:nil)
                UIView.setAnimationDuration(0.5)
                if ( cell == nil ) {
                    // cell may not have been constructed b/c it's invisible
                    continue
                }
                cell!.alpha = 0.5;
                UIView.commitAnimations()
            }
            else
            {
                UIView.beginAnimations(nil,context:nil)
                UIView.setAnimationDuration(0.5)
                cell!.alpha = 1.0;
                UIView.commitAnimations()
            }
            
        }
        
        
        
      }
    */
    
    @IBAction func returnFromDetailsView(segue:UIStoryboardSegue) {
        
    }
    func onRefresh() {
        downloadMovieData()
        self.rc!.endRefreshing()
    }
 
    func downloadMovieData()
    {
        println("downloadMovieData")
        let YourApiKey = "xe53sh2a5k9ygcczm9bd6sff"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        
        SVProgressHUD.show()
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            
            SVProgressHUD.dismiss()
            
            if ( data == nil )
            {
                println("data is nil: showing error message" )
                self.errorView.hidden = false
            }
            else
            {
                println("data is good: hiding error message" )
                self.errorView.hidden = true
                var errorValue: NSError? = nil
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:&errorValue) as NSDictionary
                
                self.movies = dictionary["movies"] as? NSArray
            }
            self.tableView.reloadData()
            println("exiting async callback")
        })
        println("returning downloadMovieData")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clearColor()
        
        downloadMovieData()
                
        self.rc = UIRefreshControl()
        self.rc?.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(rc!, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let vc = segue.destinationViewController as MovieDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell)
        
        vc.movie = self.movies![indexPath!.row] as NSDictionary
        
        println("onClick")
        
    }

}
