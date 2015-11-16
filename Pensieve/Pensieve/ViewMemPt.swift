//
//  ViewMemPt.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 11/15/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData

class ViewMemPt: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    @IBOutlet weak var memptDateLabel: UILabel!
    @IBOutlet weak var memptTimeLabel: UILabel!
    @IBOutlet weak var memptLocLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var found = false
    
    
    // MARK: Properties
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    var image: UIImage!
    var passedName:String!
    var passedDate:String!
    var passedTime:String!
    var passedLoc:String!
    var passedFileLoc:String!
    var passedId:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memNameLabel.text = passedName
        memptDateLabel.text = passedDate
        memptTimeLabel.text = passedTime
        memptLocLabel.text = passedLoc
        findImg()
    }
    
    func findImg(){
    
    /* Create the fetch request first */
    let fetchRequest = NSFetchRequest(entityName: "Memory")
    
    
    /* And execute the fetch request on the context */
    
        do {
            let mems = try managedObjectContext.executeFetchRequest(fetchRequest)
            for memory in mems{
                if((memory.valueForKey("memname")as? String!)==(passedName as? String!)) {
                    if (!found) {
                        if((memory.valueForKey("memtime")as? String!)==(passedTime as? String!)) {
                            if ((memory.valueForKey("pointid")as? String!)==(passedId as? String!)) {
                            
                            //let checkValidation = NSFileManager.defaultManager()
                            //if (checkValidation.fileExistsAtPath(memory.valueForKey("picfileloc")) as? NSData!) {
                            
                            //if (UIImage(data: ((memory.valueForKey("picfileloc")) as? NSData)!) != nil) {
                                print("Reached inside the loop")
                            
                            do {
                                print("ImageData = \(_stdlib_getDemangledTypeName(UIImage(data: ((memory.valueForKey("picfileloc")) as? NSData)!)))")
                                image = UIImage(data: ((memory.valueForKey("picfileloc")) as? NSData)!)
                                if ((image) != nil) {
                                    imageView.image = image
                                    UIView.animateWithDuration(2.0, animations: {
                                        self.imageView.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
                                    })
                                    UIView.animateWithDuration(2.0, animations: {
                                        self.imageView.transform = CGAffineTransformMakeRotation((360.0 * CGFloat(M_PI)) / 180.0)
                                    })
                                }
                                found = true
                                break
                            } catch let error as NSError {
                                print(error)
                            }
                            
                                /*image = UIImage(data: ((memory.valueForKey("picfileloc")) as? NSData)!)
                                found = true
                                //image = memory.valueForKey("picfileloc") as!UIImage
                                
                                if ((image) != nil) {
                                    imageView.image = image
                                    UIView.animateWithDuration(2.0, animations: {
                                        self.imageView.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
                                    })
                                }
                                break
*/

                            //}
                            /*print("Reached inside the loop")
                            image = UIImage(data: ((memory.valueForKey("picfileloc")) as? NSData)!)
                            found = true
                            //image = memory.valueForKey("picfileloc") as!UIImage
                            imageView.image = image
                            break
                            */
                            }
                        }
                    }
                }
            }
    
        } catch let error as NSError{
            print(error)
        }
        print("Image loop complete")
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
