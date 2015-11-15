//
//  MemoryViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/26/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData

class MemoryViewController: UIViewController {
    @IBOutlet weak var passedMemName: UILabel!
    @IBOutlet weak var passedMemDate: UILabel!
    @IBOutlet weak var passedMemTime: UILabel!
    @IBOutlet weak var MemPointTable: UITableView!
    
    var passName:String!
    var passDate:String!
    var passTime:String!
    var names = [String]()
    
    // MARK: Properties
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passedMemName.text = passName;
        passedMemDate.text = passDate;
        passedMemTime.text = passTime;
        title = "Pensieve"
        populateNames()
        MemPointTable.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")

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
    
    
    func populateNames(){
        
        /* Create the fetch request first */
        let fetchRequest = NSFetchRequest(entityName: "Memory")
        
        
        /* And execute the fetch request on the context */
        
        do {
            
            let mems = try managedObjectContext.executeFetchRequest(fetchRequest)
            for memory in mems{
                if(!((memory.valueForKey("picfileloc")as? String!)==("MainNotPoint"))){
                    if((memory.valueForKey("memname")as? String!)==(passName)){
                    names.append((memory.valueForKey("memtime")as? String)!)
                    }
                }
            }
            
        }catch let error as NSError{
            print(error)
        }
    }
    
    func tableView(MemPointTable: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return names.count
    }
    
    func tableView(MemPointTable: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            MemPointTable.dequeueReusableCellWithIdentifier("Cell")
            
            cell!.textLabel!.text = names[indexPath.row]
            
            return cell!
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
