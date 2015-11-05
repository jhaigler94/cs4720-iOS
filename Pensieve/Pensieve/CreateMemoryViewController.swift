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

class CreateMemoryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    // MARK: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    @IBOutlet weak var memNameTextField: UITextField!
    @IBOutlet weak var memDateTextField: UITextField!
    @IBOutlet weak var memTimeTextField: UITextField!
    
    var placePicker: GMSPlacePicker?
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
    
    override func viewDidAppear(animated: Bool) {
        var nav = self.navigationController?.navigationBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SaveInformation(sender: AnyObject) {
        print("Button Pressed")
        createNewMemory(memNameTextField.text!, date:  memDateTextField.text!, time:
            memTimeTextField.text!)
    }
    
    @IBAction func SaveInfo(sender: UIButton) {
        print("Button Pressed")
        createNewMemory(memNameTextField.text!, date:  memDateTextField.text!, time:
            memTimeTextField.text!)
        
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
        date:String,
        time: String) -> Bool{
            
            print("Begininng")
            let newMem =
            NSEntityDescription.insertNewObjectForEntityForName("Memory",
                inManagedObjectContext: managedObjectContext) //as! Pensieve.Memory
            print("HERE?")
            
            newMem.setValue(name, forKey: "memname")
            newMem.setValue(time, forKey: "memtime")
            newMem.setValue(date, forKey: "memdate")
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
                self.locNameLabel.text = place.name
                self.locAddLabel.text = place.formattedAddress.componentsSeparatedByString(", ").joinWithSeparator("\n")
            } else {
                self.locNameLabel.text = "No Place Selected"
                self.locAddLabel.text = ""
            }
        })
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
