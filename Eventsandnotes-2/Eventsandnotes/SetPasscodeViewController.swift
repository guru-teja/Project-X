//
//  SetPasscodeViewController.swift
//  Eventsandnotes
//
//  Created by Ganesh on 8/11/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit

class SetPasscodeViewController: UIViewController, UITextFieldDelegate
{
    
    var i = 0
    var password = ""
    var confirmPassword = ""
    var enterpassword = ""
    var currentpassword = ""
 
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var btn1: CustomButton!
    @IBOutlet weak var btn2: CustomButton!
    @IBOutlet weak var btn3: CustomButton!
    @IBOutlet weak var btn4: CustomButton!
    @IBOutlet weak var btn5: CustomButton!
    @IBOutlet weak var btn6: CustomButton!
    @IBOutlet weak var btn7: CustomButton!
    @IBOutlet weak var btn8: CustomButton!
    @IBOutlet weak var btn9: CustomButton!
    @IBOutlet weak var btn0: CustomButton!

    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnClear: CustomButton!

    
    
    func handleInput(str: String)  //Pavan and Venkatesh
    {
    txtField.text = txtField.text! + str
    
    if txtField.text?.characters.count == 4
    {
        if i==0
        {
            
            label.text = "Set Passcode"
             btnClear.hidden = true
            password = txtField.text!
            txtField.text = ""
            label.text = "Confirm Passcode"
            i = i + 1
        }
            
        else if i == 1
        {
            label.text = "Confirm passcode"
              btnClear.hidden = true
            confirmPassword = txtField.text!
            txtField.text = ""
//            label.text = "Confirm passcode"
            if confirmPassword == password
                
            {
                var initialPassword: NSString = password
                NSUserDefaults.standardUserDefaults().setObject(initialPassword, forKey:"setpassword")
                NSUserDefaults.standardUserDefaults().synchronize()
                print(" Account Succesfully Created With Password \(initialPassword)")
                
                let next = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                self.presentViewController(next, animated: true, completion: nil)
            }
                
            else
                
            {
                UIAlertView.init(title: "Login Failed", message: "Passwords do not match", delegate: nil, cancelButtonTitle: "OK").show()
                i = 0
                label.text = "Set Passcode"
            }
            
        }
        else if i == 2
        {
            print("")
            btnClear.hidden = true
            label.text = "Enter Passcode"
            enterpassword = txtField.text!
            txtField.text! = ""
            if enterpassword ==  NSUserDefaults.standardUserDefaults().stringForKey("setpassword")
            {
                let next = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                self.presentViewController(next, animated: true, completion: nil)
                
                //self.dismissViewControllerAnimated(true , completion: nil)
                //if we want to return to the previousviewcontroller before coming to foreground
                
            }
            else
                
            {
                UIAlertView.init(title: "Login Failed", message: "Please enter Correct Password", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
        }
            
        else if i == 3
        {
//            label.text = "current Passcode"
            currentpassword = txtField.text!
            txtField.text! = ""
            if currentpassword ==  NSUserDefaults.standardUserDefaults().stringForKey("setpassword")
            {
                
                i = 0
                label.text = "Set Passcode"
                btnClear.hidden = true
            }
            else
            {
                UIAlertView.init(title: "Passcode not matched", message: "Please enter Correct Password", delegate: nil, cancelButtonTitle: "OK").show()
                return
                
            }
        }
        }
    }
    
    
    @IBAction func btnClearPress(sender: UIButton) // Pavan
    {
        txtField.text = ""
    }
    
    @IBAction func btnDeletePress(sender: AnyObject) // Pavan
    {
        let name: String = self.txtField.text!
        let stringLength = txtField.text?.characters.count
        let substringIndex = stringLength! - 1
        txtField.text = (name as NSString).substringToIndex(substringIndex)
    }
    
    @IBAction func btnAction (sender: CustomButton) // Pavan
    {
        handleInput("\(sender.tag)")
    }
    
    
    
    override func viewDidLoad()  // Venkatesh
    {
        super.viewDidLoad()
        txtField.delegate = self
        
        if i == 3
        {
            i = 3
            label.text = "Current passcode"
        }
            
        else
            
        {
            
            if NSUserDefaults.standardUserDefaults().stringForKey("setpassword") == nil
            {
                i = 0
                btnClear.hidden = true
            }
            else
            {
                i = 2
                label.text = "Enter Passcode"
                btnClear.hidden = true
            }
            // Do any additional setup after loading the view, typically from a nib.
        }
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}


}