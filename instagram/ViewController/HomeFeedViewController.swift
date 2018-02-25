//
//  HomeFeedViewController.swift
//  instagram
//
//  Created by Ali Fenton on 2/25/18.
//  Copyright © 2018 Ali Fenton. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var homeFeedTableView: UITableView!
    var posts: [Post] = []
    var refreshControl : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.didPullToReFresh(_:)), for: .valueChanged)
        homeFeedTableView.insertSubview(refreshControl, at: 0)
        self.homeFeedTableView.dataSource = self
        self.homeFeedTableView.delegate = self
        fetchFeed()
        // Do any additional setup after loading the view.
    }
    @objc func didPullToReFresh(_ refreshControl: UIRefreshControl){
        fetchFeed()
    }
    
    func fetchFeed(){
        let query = Post.query()
        query?.limit = 20
        query?.order(byDescending: "_created_at")
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if  posts != nil {
                // do something with the data fetched
                self.posts = posts as! [Post]
                self.homeFeedTableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        })
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.section]
        cell.captionLabel.text = post.caption
        cell.postImageView.file = post.media
        cell.postImageView.loadInBackground()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginViewController, animated: true, completion: nil)
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let vc = segue.destination as! DetailPostViewController
            let senderCell = sender as! PostCell
            
            let indexPath = homeFeedTableView.indexPath(for: senderCell)
            
            let df = DateFormatter()
            df.dateStyle = .short
            df.timeStyle = .short
            df.locale = Locale.current
            
            
            vc.postDate = df.string(from: self.posts[(indexPath?.section)!].createdAt!)
            vc.imageFile = self.posts[(indexPath?.section)!].media
            vc.postCaption = self.posts[(indexPath?.section)!].caption
        }else if segue.identifier == "composeSegue"{
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
