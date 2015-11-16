//
//  ViewMemPt.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 11/15/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit

class ViewMemPt: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    @IBOutlet weak var memptDateLabel: UILabel!
    @IBOutlet weak var memptTimeLabel: UILabel!
    @IBOutlet weak var memptLocLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var passedName:String!
    var passedDate:String!
    var passedTime:String!
    var passedLoc:String!
    var passedFileLoc:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memNameLabel.text = passedName
        memptDateLabel.text = passedDate
        memptTimeLabel.text = passedTime
        memptLocLabel.text = passedLoc
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
