//
//  DetailPostViewController.swift
//  instagram
//
//  Created by Ali Fenton on 2/25/18.
//  Copyright © 2018 Ali Fenton. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailPostViewController: UIViewController {
    @IBOutlet weak var detailPostImageView: PFImageView!
    @IBOutlet weak var detailPostDateLabel: UILabel!
    @IBOutlet weak var detailPostCaptionLabel: UILabel!
    
    var imageFile: PFFile!
    var postDate: String!
    var postCaption: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPostImageView.file = imageFile
        detailPostImageView.loadInBackground()
        detailPostCaptionLabel.text = postCaption
        detailPostDateLabel.text = postDate
        // Do any additional setup after loading the view.
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
