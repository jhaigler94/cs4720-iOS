//
//  ViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/19/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    var names = [String]()
    var memName = String()
    var memDate = String()
    var memTime = String()
    
    // MARK: Properties
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pensieve"
        populateNames()
        TableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func populateNames(){
        
        /* Create the fetch request first */
        let fetchRequest = NSFetchRequest(entityName: "Memory")
        
        
        /* And execute the fetch request on the context */
        
        do {
           
                let mems = try managedObjectContext.executeFetchRequest(fetchRequest)
                for memory in mems{
                    if((memory.valueForKey("picfileloc")as? String!)==("MainNotPoint")){
                    names.append((memory.valueForKey("memname")as? String)!)
                    }
        }
            
        }catch let error as NSError{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func tableView(TableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return names.count
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        let fetchRequest = NSFetchRequest(entityName: "Memory")
        
        
        /* And execute the fetch request on the context */
        
        do {
            
            let mems = try managedObjectContext.executeFetchRequest(fetchRequest)
            for memory in mems{
                if((memory.valueForKey("memname")as? String!)==((names[indexPath.row])as?String!)){
                    if((memory.valueForKey("picfileloc")as? String!)==("MainNotPoint")){
                    memName = ((memory.valueForKey("memname")as? String)!)
                    memDate = ((memory.valueForKey("memdate")as? String)!)
                    memTime = ((memory.valueForKey("memtime")as? String)!)                }
            
                }
            }
        }catch let error as NSError{
            print(error)
        }
        NSLog(memName)
        NSLog(memDate)
        NSLog(memTime)
        
        //self.performSegueWithIdentifier("ToMemPtListSeg", sender: self)
    }
    
    // MARK: Segue
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      //  if (segue.identifier == "ToMemPtListSeg") {
        //    var memVC = segue.destinationViewController as! MemoryViewController;
            
      //      memVC.passName = memName
       //     memVC.passDate = memDate
         //   memVC.passTime = memTime
       // }
    //}
    
    func tableView(TableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            TableView.dequeueReusableCellWithIdentifier("Cell")
            
            cell!.textLabel!.text = names[indexPath.row]
            
            return cell!
    }
    
    
    // MARK: Actions
    
    // MARK: Segues
    
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        if let memViewController = unwindSegue.sourceViewController as? MemoryViewController {
            print("Coming from MemoryViewController")
        }
    }
    


}

