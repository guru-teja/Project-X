//
//  SecondViewController.swift
//  Eventsandnotes
//
//  Created by Ganesh on 8/10/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit
import CoreData // Yasaswi

class SecondViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate ,UITextFieldDelegate{

    @IBOutlet weak var titlename: UITextField!
    
    @IBOutlet weak var note: UITextView!
    
    
    @IBOutlet weak var image: UIImageView!
    
       let imagePicker = UIImagePickerController()
    var isUpdate:Bool?
    
    @IBAction func addimage(sender: UIButton) {
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
            titlename.text = s.sTitle
            
            note.text = s.sNote
            
            
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
    
    
    @IBAction func save(sender: UIBarButtonItem) {
    
        
        if isUpdate == true{
            print("object id \(self.store?.objectID)")
            self.store?.sTitle = titlename.text
            self.store?.sNote = note.text
            let imgData = UIImageJPEGRepresentation(image.image!,1)
            self.store?.sImage = imgData
            do {
                try appdelegate.managedObjectContext.save()
                self.navigationController?.popViewControllerAnimated(true)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }else{
            //get the description of the entity
            let storeDescription = NSEntityDescription.entityForName("Store",inManagedObjectContext: appdelegate.managedObjectContext)
            
            //we create managed object to be inserted to core data
            let store = EventsandnotesStore(entity : storeDescription!,insertIntoManagedObjectContext:appdelegate.managedObjectContext)
            store.sTitle = titlename.text
            store.sNote = note.text
            let imgData = UIImageJPEGRepresentation(image.image!,1)
            
            store.sImage = imgData
            do
            {
                try appdelegate.managedObjectContext.save()
                self.navigationController?.popViewControllerAnimated(true)
            }
            catch let error as NSError
            {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            image.contentMode = .ScaleAspectFit
            image.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}
