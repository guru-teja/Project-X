import UIKit
import CoreData

class TableViewController: UITableViewController  // Mounica
{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var stores = [EventsandnotesStore]()
    
    @IBOutlet var tableview1: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(animated : Bool)
    {
        
    }
    
    override func viewWillAppear(animated: Bool)
    
    {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Store")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            stores = results as! [EventsandnotesStore]
            for store in stores {
                //print("Event name \(store.sName!)")
            }
            self.tableview1.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let store = stores[indexPath.row]//stores[indexPath.row] as EventsandnotesStore
        cell.textLabel!.text = store.sName
        cell.detailTextLabel?.text = store.sDescription
        cell.imageView?.image = UIImage(data:store.sImage!)
        
        
        return cell
        
    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            stores.removeAtIndex(indexPath.row)
//            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
   // https://github.com/guru-teja/Project-X
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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
        
        if segue.identifier == "show"
        {
            let v = segue.destinationViewController as! ViewController
            let indexpath = self.tableView.indexPathForSelectedRow!
            let row = indexpath.row
            v.store = stores[row]
            v.isUpdate = true
        }
        else if segue.identifier == "push"{
            let v = segue.destinationViewController as! ViewController
            v.isUpdate = false
        }
    }
    
}
