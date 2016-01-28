//
//  ViewController.swift
//  InstagramFeed
//
//  Created by Brian Lee on 1/21/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var instaTableView: UITableView!
    
    var feed: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        instaTableView.delegate = self
        instaTableView.dataSource = self
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.feed = responseDictionary["data"] as? [NSDictionary]
                            self.instaTableView.reloadData()
                    }
                }
        });
        task.resume()
        
        instaTableView.rowHeight = 320;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let feed = feed{
            return feed.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        //let username = UILabel(frame: CGRect(x: 30, y: 10, width: 300, height: 30))
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        // profileView.setImageWithURL(...)
        
        headerView.addSubview(profileView)
        //headerView.addSubview(username)
        
        // Add a UILabel for the username here
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = instaTableView.dequeueReusableCellWithIdentifier("PhotosCell", forIndexPath: indexPath) as! PhotosCell
        
        let post = feed![indexPath.section]
        let images = post["images"] as! NSDictionary
        let stdRes = images["standard_resolution"] as! NSDictionary
        
        let imageUrl = stdRes["url"] as! String
        let url = NSURL(string: imageUrl)
        
        cell.photoImageView.setImageWithURL(url!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        instaTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = instaTableView.indexPathForCell(sender as! UITableViewCell)
        
        let cell = feed![(indexPath?.section)!]
        let images = cell["images"] as! NSDictionary
        let stdRes = images["standard_resolution"] as! NSDictionary
        
        let imageUrl = stdRes["url"] as! String
        
        vc.imageURL = imageUrl
        
    }
    
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let feed = feed {
//            return feed.count
//        } else {
//            return 0
//        }
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = instaTableView.dequeueReusableCellWithIdentifier("PhotosCell", forIndexPath: indexPath) as! PhotosCell
//        
//        let post = feed![indexPath.row]
//        let images = post["images"] as! NSDictionary
//        let stdRes = images["standard_resolution"] as! NSDictionary
//        
//        let imageUrl = stdRes["url"] as! String
//        let url = NSURL(string: imageUrl)
//        
//        cell.photoImageView.setImageWithURL(url!)
//        
//        return cell
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

