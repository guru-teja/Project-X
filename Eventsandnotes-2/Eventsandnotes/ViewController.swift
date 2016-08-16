
//
//  ViewController.swift
//  Eventsandnotes
//
//  Created by Ganesh on 8/9/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit
import CoreData      // Mounica


class ViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    
   @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var desc: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var isUpdate:Bool?
    var switchvalue:Bool = true
    
    
    @IBOutlet weak var datePicker: UIDatePicker!  // Teja
    
    @IBAction func datePickerAction(sender: UIDatePicker)
    {
    
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        
    }
    
    
    @IBAction func addimage1(sender: UIButton)
    {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    var store: EventsandnotesStore?
    
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if let s = store
            
        {
            name.text = s.sName
            desc.text = s.sDescription
            
        }
        
        if self.isUpdate == true
        {
            self.navigationItem.rightBarButtonItem?.title = "Update"
        }
        else
        {
            self.navigationItem.rightBarButtonItem?.title = "Save"
        }
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
    }
    
    @IBAction func mySwitch(sender: UISwitch)  // Teja
    {
        
        if sender.on
        {
            switchvalue = true
            print ("switch is on, So true and give notification")
        }
        else
        {
            switchvalue = false
            print("switch is off, So false and dont give notifications")
        }
        
    }
    
    @IBAction func additem(sender: UIBarButtonItem)
    {
        
        var localNotification = UILocalNotification()
        
        localNotification.alertTitle = name.text
        
        localNotification.alertBody = desc.text
        
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        
        
        if switchvalue == true
        {
            //localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
            localNotification.fireDate = datePicker.date
        }
        
        if isUpdate == true
        {
            print("object id \(self.store?.objectID)")
            self.store?.sName = name.text
            self.store?.sDescription = desc.text
            
            let imgData = UIImageJPEGRepresentation(imageView.image!,1)
            self.store?.sImage = imgData
            
            do
            {
                try appdelegate.managedObjectContext.save()
                self.navigationController?.popViewControllerAnimated(true)
            }
            catch let error as NSError
            {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }else{
            //get the description of the entity
            let storeDescription = NSEntityDescription.entityForName("Store",inManagedObjectContext: appdelegate.managedObjectContext)
            
            //we create managed object to be inserted to core data
            let store = EventsandnotesStore(entity : storeDescription!,insertIntoManagedObjectContext:appdelegate.managedObjectContext)
            store.sName = name.text
            store.sDescription = desc.text
           
            
            var imgData = UIImageJPEGRepresentation(imageView.image!,1)
            
            store.sImage = imgData
            do {
                try appdelegate.managedObjectContext.save()
                self.navigationController?.popViewControllerAnimated(true)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
