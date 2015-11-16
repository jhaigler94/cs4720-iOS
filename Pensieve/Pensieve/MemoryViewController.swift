//
//  MemoryViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/26/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData

class MemoryViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var passedMemName: UILabel!
    @IBOutlet weak var passedMemDate: UILabel!
    @IBOutlet weak var passedMemTime: UILabel!
    @IBOutlet weak var MemPointTable: UITableView!
    
    
    var memName = String()
    var memDate = String()
    var memTime = String()
    var memLoc = String()
    var memId = String()
    //var picFileLoc = String()
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
        /*populateNames()
        MemPointTable.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        */

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("VIEWDIDAPPEAR: MEMORYVIEW")
        names = []
        populateNames()
        MemPointTable.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        
        //MemPointTable.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        let fetchRequest = NSFetchRequest(entityName: "Memory")
        
        
        /* And execute the fetch request on the context */
        
        do {
            
            let mems = try managedObjectContext.executeFetchRequest(fetchRequest)
            for memory in mems{
                if((memory.valueForKey("memname")as? String!)==((passedMemName.text)as?String!)){
                    if((memory.valueForKey("pointid")as? String!)==(names[indexPath.row])){
                        memName = ((memory.valueForKey("memname")as? String)!)
                        memDate = ((memory.valueForKey("memdate")as? String)!)
                        memTime = ((memory.valueForKey("memtime")as? String)!)
                        memLoc = ((memory.valueForKey("memloc")as? String)!)
                        memId = ((memory.valueForKey("pointid")as? String)!)
                        //picFileLoc = ((memory.valueForKey("picfileloc")as? String)!)
                    }
                }
            }
        }catch let error as NSError{
            print(error)
        }
        NSLog(memName)
        NSLog(memDate)
        NSLog(memTime)
        
        self.performSegueWithIdentifier("ToViewMemPt", sender: self)
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToCreateMemPtSeg") {
            var cMemVC = segue.destinationViewController as! CreateMemPtViewController;
            
            cMemVC.passFromMemName = passedMemName.text
        }
        
        else if (segue.identifier == "ToViewMemPt") {
            var memVC = segue.destinationViewController as! ViewMemPt;
            
            memVC.passedName = memName
            memVC.passedDate = memDate
            memVC.passedTime = memTime
            memVC.passedLoc = memLoc
            memVC.passedId = memId
            //memVC.passedFileLoc = picFileLoc
        }
        
        
    }
    
    @IBAction func unwindToMemView(unwindSegue: UIStoryboardSegue) {
        if let memViewController = unwindSegue.sourceViewController as? CreateMemPtViewController {
            print("Coming from CreateMemPtViewController")
        }
    }
    
    
    func populateNames(){
        
        /* Create the fetch request first */
        let fetchRequest = NSFetchRequest(entityName: "Memory")
        
        
        /* And execute the fetch request on the context */
        
        do {
            
            let mems = try managedObjectContext.executeFetchRequest(fetchRequest)
            for memory in mems{
                if(!((memory.valueForKey("memloc")as? String!)==("MainNotPoint"))){
                    if((memory.valueForKey("memname")as? String!)==(passName)){
                    
                    names.append(((memory.valueForKey("pointid")as? String)!))
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
