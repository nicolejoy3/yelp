//
//  MainViewController.swift
//  instagram_demo
//
//  Created by Elizabeth on 2/21/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]?
    var refreshControl: UIRefreshControl!
    // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
    // immediately.  Any code that depends on the query result should be moved
    // inside the completion block above.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MainViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        // Table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        
        //main timeline() function call
        timelineCall()
 
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        timelineCall()
    }
    
    func timelineCall() {
        let query = PFQuery(className: "media")
        query.order(byDescending: "_created_at")
        query.limit = 20
        
        //Parse
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                print("We got some posts")
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print("Error fetching timeline in function timelineCall(): \(error!.localizedDescription)")
            }
        }
    }

    
    @IBAction func onLogoutBtn(_ sender: Any) {
        //log the user out
        PFUser.logOutInBackground { (error: Error?) in
            if error == nil {
                print("Successful logout")
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            } else {
                print("Error Logging Out!")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("count returned: ", self.posts?.count as Any)
        return self.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainPhotoCell", for: indexPath) as! mainPhotoCell
        let post = posts?[indexPath.row]
        
        cell.userPost = posts?[indexPath.row]
         cell.captionLabel.text = post?["caption"] as? String
         
         
         if let postimage = post?["media"] as? PFFile {
            postimage.getDataInBackground(block: { (data: Data?, error: Error?) in
                if let image = UIImage(data: data!) {
                    cell.postedPicImageView.image = image
                }
            })
        }
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
