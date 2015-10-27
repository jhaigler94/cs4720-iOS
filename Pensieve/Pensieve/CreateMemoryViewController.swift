//
//  CreateMemoryViewController.swift
//  Pensieve
//
//  Created by Jennifer Ruth Haigler on 10/19/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import UIKit

class CreateMemoryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var memNameLabel: UILabel!
    @IBOutlet weak var memNameTextField: UITextField!
    @IBOutlet weak var memDateTextField: UITextField!
    @IBOutlet weak var memTimeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Handle the text field’s user input through delegate callbacks.
        //memNameTextField.delegate = self
        memNameLabel.text = memNameTextField.text
        
    }
    
    override func viewDidAppear(animated: Bool) {
        var nav = self.navigationController?.navigationBar
        
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
