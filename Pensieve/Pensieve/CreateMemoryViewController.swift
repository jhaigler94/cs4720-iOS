//
//  CreateMemoryViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/19/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import CoreLocation

class CreateMemoryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    // MARK: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    @IBOutlet weak var memNameTextField: UITextField!
    @IBOutlet weak var memDateTextField: UITextField!
    @IBOutlet weak var memTimeTextField: UITextField!
    
    var placePicker: GMSPlacePicker?
    var locationManager: CLLocationManager?
    var lat:String! = "38"
    var lon:String! = "-78"
    @IBOutlet weak var locNameLabel: UILabel!
    @IBOutlet weak var locAddLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Handle the text field’s user input through delegate callbacks.
        //memNameTextField.delegate = self
        //memNameLabel.text = memNameTextField.text
        
        //placePicker = GMSPlacePicker()
        
    }
    
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
    
    
    override func viewDidAppear(animated: Bool) {
        var nav = self.navigationController?.navigationBar
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SaveInformation(sender: AnyObject) {
        print("Button Pressed")
        var locName = locNameLabel.text
        if locNameLabel.text == "Location Name" {
            locName = ""
        }
        createNewMemory(memNameTextField.text!, date:  memDateTextField.text!, time:
            memTimeTextField.text!, loc: locName!)
    }
    
    @IBAction func SaveInfo(sender: UIButton) {
        print("Button Pressed")
        var locName = locNameLabel.text
        if locNameLabel.text == "Location Name" {
            locName = ""
        }
        createNewMemory(memNameTextField.text!, date:  memDateTextField.text!, time:
            memTimeTextField.text!, loc: locName!)
        
    }
    
    /*@IBAction func SaveInfo(sender: AnyObject) {
        createNewMemory(memNameTextField.text!, date:  memDateTextField.text!, time:
            memTimeTextField.text!)
    }
*/
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        memNameLabel.text = textField.text
    }


    // MARK: Actions

    // MARK: DatePicker
    
    @IBAction func selectDatePicker(sender: UITextField) {
        
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
        memDateTextField.resignFirstResponder()
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        memDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    
    // MARK: TimePicker
    @IBAction func selectTimePicker(sender: UITextField) {
        
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
        memTimeTextField.resignFirstResponder()
    }
    
    func handleTimePicker(sender: UIDatePicker) {
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        memTimeTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    func createNewMemory(name: String,
        date: String,
        time: String, loc: String) -> Bool{
            
            print("Begininng")
            let newMem =
            NSEntityDescription.insertNewObjectForEntityForName("Memory",
                inManagedObjectContext: managedObjectContext) //as! Pensieve.Memory
            print("HERE?")
            
            newMem.setValue(name, forKey: "memname")
            newMem.setValue(time, forKey: "memtime")
            newMem.setValue(date, forKey: "memdate")
            newMem.setValue("0", forKey: "pointid")
            newMem.setValue("MainNotPoint", forKey: "memloc")
            //(newMem.memname, newMem.memdate, newMem.memtime) =
              //  (name, date, time)
            
            do{
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Failed to save the new person. Error = \(error)")
            }
            
            return false
            
    }
    
    // MARK: Google Place Picker
    @IBAction func GetLocation(sender: UIButton) {
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
                    self.locNameLabel.text = place.name
                    if (place.formattedAddress != nil) {
                        self.locAddLabel.text = place.formattedAddress.componentsSeparatedByString(", ").joinWithSeparator("\n")
                    }
                } else {
                    self.locNameLabel.text = "No Place Selected"
                    self.locAddLabel.text = ""
                }
            })
        }

        if CLLocationManager.locationServicesEnabled() {
            let mylat = Double(lat)
            let mylon = Double(lon)
            
        }
        
        else {
            var alert = UIAlertController(title: "Alert", message: "Location Services disabled for this application.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)        }
    }
    
    // MARK: Location
   
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
        if (segue.identifier == "ToMemPtListSeg") {
            var memVC = segue.destinationViewController as! MemoryViewController;
            
            memVC.passName = memNameTextField.text
            memVC.passDate = memDateTextField.text
            memVC.passTime = memTimeTextField.text
        }
    }
    
    @IBAction func cancelCreate(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
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
