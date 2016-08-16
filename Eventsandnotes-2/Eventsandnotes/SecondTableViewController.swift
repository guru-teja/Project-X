//
//  SecondTableViewController.swift
//  Eventsandnotes
//
//  Created by Ganesh on 8/10/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit
import CoreData             //  Yasaswi

class SecondTableViewController: UIViewController{

     let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var stores = [EventsandnotesStore]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    
    override func viewDidAppear(animated : Bool){
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Store")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            stores = results as! [EventsandnotesStore]
            for store in stores {
               
            }
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) 
        let store = stores[indexPath.row]//stores[indexPath.row] as EventsandnotesStore
        cell1.textLabel!.text = store.sTitle
        cell1.detailTextLabel?.text = store.sNote
        cell1.imageView?.image = UIImage(data:store.sImage!)
    
        
        return cell1
        
    }
    

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(stores[indexPath.row] as NSManagedObject)
            stores.removeAtIndex(indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }// context.save()
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "show1"
        {
            let v = segue.destinationViewController as! SecondViewController
            let indexpath = self.tableView.indexPathForSelectedRow!
            let row = indexpath.row
            v.store = stores[row]
            v.isUpdate = true
        }else if segue.identifier == "push1"{
            let v = segue.destinationViewController as! SecondViewController
            v.isUpdate = false
        }

    }
}