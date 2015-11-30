//
//  ViewMemPt.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 11/15/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData
import SwiftyDropbox

class ViewMemPt: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    @IBOutlet weak var memptDateLabel: UILabel!
    @IBOutlet weak var memptTimeLabel: UILabel!
    @IBOutlet weak var memptLocLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var found = false
    var good = false
    
    // MARK: Properties
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    var image: UIImage!
    var passedName:String!
    var passedDate:String!
    var passedTime:String!
    var passedLoc:String!
    var passedFileLoc:String!
    var passedId:String!
    
    @IBAction func dropboxUpload(sender: AnyObject) {
        if (Dropbox.authorizedClient == nil) {
            Dropbox.authorizeFromController(self)
        } else {
            print("User is already authorized!")
        }
        if(!(Dropbox.authorizedClient == nil)){
            let client = Dropbox.authorizedClient
            print(client)
        let pathText = "/" + memNameLabel!.text! + " " + memptTimeLabel!.text! + "picture.jpeg"
        let imageData = UIImagePNGRepresentation(imageView.image!)
        let fileData = imageData
        client!.files.upload(path: "/" + memNameLabel!.text! + " " + memptTimeLabel!.text! + "picture.jpeg", body: fileData!).response { response, error in
            if let metadata = response {
                print("*** Upload file ****")
                print("Uploaded file name: \(metadata.name)")
                print("Uploaded file revision: \(metadata.rev)")
                
                client!.files.getMetadata(path: pathText).response { response, error in
                    print("*** Get file metadata ***")
                    if let metadata = response {
                        print(metadata)
                        if let file = metadata as? Files.FileMetadata {
                            print("This is a file with path: \(file.pathLower)")
                            print("File size: \(file.size)")
                            self.displayAlertWithTitle("Saved", message: "at path: \(file.pathLower)" )
                        } else if let folder = metadata as? Files.FolderMetadata {
                            print("This is a folder with path: \(folder.pathLower)")
                        }
                    }else{
                        print(error!)
                    }
                }
            }
            }
        }

    }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }

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
