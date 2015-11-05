//
//  MemoryViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/26/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    @IBOutlet weak var passedMemName: UILabel!
    @IBOutlet weak var passedMemDate: UILabel!
    @IBOutlet weak var passedMemTime: UILabel!
    
    var passName:String!
    var passDate:String!
    var passTime:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passedMemName.text = passName;
        passedMemDate.text = passDate;
        passedMemTime.text = passTime;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToCreateMemPtSeg") {
            var cMemVC = segue.destinationViewController as! CreateMemPtViewController;
            
            cMemVC.passName = passedMemName.text
        }
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
