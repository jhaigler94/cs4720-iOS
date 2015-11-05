//
//  ViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/19/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    var names = [String]()
    
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
                    
                    names.append((memory.valueForKey("memname")as? String)!)
                    
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

