//
//  CreateMemPtViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/26/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

class CreateMemPtViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Mark: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var memptDateTextField: UITextField!
    @IBOutlet weak var memptTimeTextField: UITextField!
    var placePicker: GMSPlacePicker?
    @IBOutlet weak var memptLocNameLabel: UILabel!
    @IBOutlet weak var memptLocAddLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    

    
    var passName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        memNameLabel.text = passName
        var stackFrame = stackView.frame
        stackFrame.size.width = UIScreen.mainScreen().bounds.width
        stackView.frame = stackFrame
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func takePhotoButton(sender: UIBarButtonItem) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .Camera
                imagePickerController.delegate = self
                
                presentViewController(imagePickerController, animated: true, completion: nil)
            } else {
                var alert = UIAlertController(title: "Rear camera doesn't exist", message: "Application cannot access the camera.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                print("Application cannot access the camera.")
                //postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            var alert = UIAlertController(title: "Camera Inaccessable", message: "Application cannot access the camera.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

        print("Camera inaccessable.")
        //postAlert("Camera inaccessable", message: "Application cannot access the camera.")
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .Camera
                imagePickerController.delegate = self
                
                presentViewController(imagePickerController, animated: true, completion: nil)
            } else {
                var alert = UIAlertController(title: "Rear camera doesn't exist", message: "Application cannot access the camera.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                print("Application cannot access the camera.")
                //postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            var alert = UIAlertController(title: "Camera Inaccessable", message: "Application cannot access the camera.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //print("Camera inaccessable.")
        //postAlert("Camera inaccessable", message: "Application cannot access the camera.")
    }
    
    @IBAction func pickPhotoFromLibrary(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .PhotoLibrary
                imagePickerController.delegate = self
                
                presentViewController(imagePickerController, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Photo Library Inaccessable", message: "Application cannot access the photo library.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //print("Photo Library inaccessable.")
        //postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        

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
        var locName = memptLocNameLabel.text
        if memptLocNameLabel.text == "Location Name" {
            locName = ""
        }
        createNewMemory(memNameLabel.text!, date: memptDateTextField.text!, time: memptTimeTextField.text!, loc: locName!)
    }
    
    func createNewMemory(name: String, date: String, time: String, loc: String) -> Bool{
    
      
            print("Begininng")
            let newMem =
            NSEntityDescription.insertNewObjectForEntityForName("Memory",
                inManagedObjectContext: managedObjectContext) //as! Pensieve.Memory
            print("HERE?")
            
            newMem.setValue(name, forKey: "memname")
            print("Name Saved")
            newMem.setValue(time, forKey: "memtime")
            newMem.setValue(date, forKey: "memdate")
            newMem.setValue(loc, forKey: "memloc")
            newMem.setValue("", forKey: "picfileloc")
            
            print("All the Rest Saved")

            do{
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Failed to save the new person. Error = \(error)")
            }
            
            return false
            
    }
    
    //DatePicker
    @IBAction func pickDate(sender: UITextField) {
        print("pickdate button pressed")
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        var datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneDatePicker:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.

    }
    
    @IBAction func doneDatePicker(sender: UITextField) {
        memptDateTextField.resignFirstResponder()
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        memptDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    //TimePicker
    @IBAction func pickTime(sender: UITextField) {
        print("timepicker button pressed")
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        var timePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        timePickerView.datePickerMode = UIDatePickerMode.Time
        inputView.addSubview(timePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneTimePicker:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        timePickerView.addTarget(self, action: Selector("handleTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        handleTimePicker(timePickerView) // Set the date on start.
    }
    
    @IBAction func doneTimePicker(sender: UITextField) {
        memptTimeTextField.resignFirstResponder()
    }
    
    func handleTimePicker(sender: UIDatePicker) {
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        memptTimeTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    //LocationPicker
    @IBAction func getLocation(sender: UIButton) {
        if CLLocationManager.locationServicesEnabled() {
            let center = CLLocationCoordinate2DMake(38.0328276, -78.5105284)
            let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
            let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
            let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
            let config = GMSPlacePickerConfig(viewport: viewport)
            placePicker = GMSPlacePicker(config: config)
            
            placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
                if let error = error {
                    print("Pick Place error: \(error.localizedDescription)")
                    return
                }
                
                if let place = place {
                    self.memptLocNameLabel.text = place.name
                    if (place.formattedAddress != nil) {
                        self.memptLocAddLabel.text = place.formattedAddress.componentsSeparatedByString(", ").joinWithSeparator("\n")
                    }
                } else {
                    self.memptLocNameLabel.text = "No Place Selected"
                    self.memptLocAddLabel.text = ""
                }
            })
        }
            
        else {
            var alert = UIAlertController(title: "Alert", message: "Location Services disabled for this application.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)        }
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
