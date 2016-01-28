//
//  PhotoDetailsViewController.swift
//  InstagramFeed
//
//  Created by Brian Lee on 1/28/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: imageURL)
        photoImageView.setImageWithURL(url!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
