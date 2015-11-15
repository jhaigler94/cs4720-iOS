//
//  CreateMemPtViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/26/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData

class CreateMemPtViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Mark: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    var passName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        memNameLabel.text = passName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func takePhotoButton(sender: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .Camera
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func takePhoto(sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .Camera
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickPhotoFromLibrary(sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveMemPt(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SaveMemPoint(sender: AnyObject) {
        print("Non Bar Button Pressed")
        createNewMemory(memNameLabel.text!)
    }
    
    func createNewMemory(name: String) -> Bool{
    
      
            print("Begininng")
            let newMem =
            NSEntityDescription.insertNewObjectForEntityForName("Memory",
                inManagedObjectContext: managedObjectContext) //as! Pensieve.Memory
            print("HERE?")
            
            newMem.setValue(name, forKey: "memname")
            print("Name Saved")
            newMem.setValue("MemPtName", forKey: "memtime")
            //newMem.setValue(date, forKey: "memdate")
            newMem.setValue("", forKey: "picfileloc")
            
            print("All the Rest Saved")

            do{
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Failed to save the new person. Error = \(error)")
            }
            
            return false
            
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
