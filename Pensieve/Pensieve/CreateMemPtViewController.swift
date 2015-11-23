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
import CoreLocation

class CreateMemPtViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Mark: Properties
    var memDate: String!
    var memTime: String!
    
    @IBOutlet weak var memNameLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var memptDateTextField: UITextField!
    @IBOutlet weak var memptTimeTextField: UITextField!
    var placePicker: GMSPlacePicker?
    var locationManager: CLLocationManager?
    var lat:String!
    var lon:String!
    @IBOutlet weak var memptLocNameLabel: UILabel!
    @IBOutlet weak var memptLocAddLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    

    var imageData: NSData!
    var passFromMemName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        memNameLabel.text = passFromMemName
        var stackFrame = stackView.frame
        stackFrame.size.width = UIScreen.mainScreen().bounds.width
        stackView.frame = stackFrame
        imageData = UIImagePNGRepresentation(UIImage(named: "defaultImage")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .AuthorizedAlways:
                /* Yes, always */
                createLocationManager(startImmediately: true)
            case .AuthorizedWhenInUse:
                /* Yes, only when our app is in use */
                createLocationManager(startImmediately: true)
            case .Denied:
                /* No */
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app")
            case .NotDetermined:
                /* We don't know yet, we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = self.locationManager{
                    manager.requestWhenInUseAuthorization()
                }
            case .Restricted:
                /* Restrictions have been applied, we have no access
                to location services */
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app")
            }
            
            
        } else {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the
            user to enable the location services */
            print("Location services are not enabled")
        }

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
        imageData = UIImagePNGRepresentation(selectedImage)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveMemPt(sender: UIBarButtonItem) {
        print("Bar Button Pressed")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SaveMemPoint(sender: AnyObject) {
        print("Non Bar Button Pressed")
        var locName = memptLocNameLabel.text
        if memptLocNameLabel.text == "Location Name" {
            locName = ""
        }
        print("ImageData = \(_stdlib_getDemangledTypeName(imageData))")
        createNewMemory(memNameLabel.text!, date: memptDateTextField.text!, time: memptTimeTextField.text!, loc: locName!)
    }
    
    func createNewMemory(name: String, date: String, time: String, loc: String) -> Bool{
        var i = 0
        
        let fetchRequest = NSFetchRequest(entityName: "Memory")
        do {
            
            let mems = try managedObjectContext.executeFetchRequest(fetchRequest)
            for memory in mems{
                if((memory.valueForKey("memname")as? String!)==(name)){
                    if ((memory.valueForKey("pointid")as? String!)==("0")) {
                        memDate = (memory.valueForKey("memdate")as? String!)
                        memTime = (memory.valueForKey("memtime")as? String!)
                    }
                    i++
                }
            }
        } catch let error as NSError{
            print(error)
        }

      
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
            newMem.setValue(String(i), forKey:"pointid")
            newMem.setValue(imageData, forKey: "picfileloc")
            
            print("All the Rest Saved")
            //print("PICFILELOC: " + String(imageData))

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
            let mylat = Double(lat)
            let mylon = Double(lon)
            let center = CLLocationCoordinate2DMake(mylat!, mylon!)
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
    
    
    // MARK: Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count == 0{
            //handle error here
            return
        }
        
        let newLocation = locations[0]
        
        print("Latitude = \(newLocation.coordinate.latitude)")
        print("Longitude = \(newLocation.coordinate.longitude)")
        lat = String(newLocation.coordinate.latitude)
        lon = String(newLocation.coordinate.longitude)
        
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError){
            print("Location manager failed with error = \(error)")
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location services is changed to: ", terminator: "")
            
            switch CLLocationManager.authorizationStatus(){
            case .AuthorizedAlways:
                print("Authorized")
            case .AuthorizedWhenInUse:
                print("Authorized when in use")
            case .Denied:
                print("Denied")
            case .NotDetermined:
                print("Not determined")
            case .Restricted:
                print("Restricted")
            }
            
    }
    
    func createLocationManager(startImmediately startImmediately: Bool){
        locationManager = CLLocationManager()
        if let manager = locationManager{
            print("Successfully created the location manager")
            manager.delegate = self
            if startImmediately{
                manager.startUpdatingLocation()
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

    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToMemFromSave") {
            var SmemVC = segue.destinationViewController as! MemoryViewController
            SmemVC.passName = memNameLabel.text
            SmemVC.passDate = memDate
            SmemVC.passTime = memTime
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
