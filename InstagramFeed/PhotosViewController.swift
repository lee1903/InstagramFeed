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
                            self.feed = responseDictionary["data"] as! [NSDictionary]
                            self.instaTableView.reloadData()
                    }
                }
        });
        task.resume()
        
        instaTableView.rowHeight = 320;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feed = feed {
            return feed.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = instaTableView.dequeueReusableCellWithIdentifier("PhotosCell", forIndexPath: indexPath) as! PhotosCell
        
        let post = feed![indexPath.row]
        let images = post["images"] as! NSDictionary
        let stdRes = images["standard_resolution"] as! NSDictionary
        
        let imageUrl = stdRes["url"] as! String
        let url = NSURL(string: imageUrl)
        
        cell.photoImageView.setImageWithURL(url!)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

