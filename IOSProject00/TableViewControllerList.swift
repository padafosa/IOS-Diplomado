//
//  TableViewControllerList.swift
//  IOSProject00
//
//  Created by internet on 5/21/15.
//  Copyright (c) 2015 internet. All rights reserved.
//

import UIKit
import CoreData


class TableViewControllerList: UITableViewController, UITableViewDelegate,UITableViewDataSource  {
    var totalEntries: Int = 0
    @IBOutlet var tblLog : UITableView?
    
    
    @IBOutlet var TblList: UITableView! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Pedidos")
        request.returnsObjectsAsFaults = false
        
        totalEntries = context?.countForFetchRequest(request, error: nil) as Int!

        println(totalEntries)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return totalEntries
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Pedidos")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = context?.executeFetchRequest(request, error: nil) as NSArray!
        
        //get contents and put into cell
        var thisWeight: ManageDataBase = results[indexPath.row] as ManageDataBase

        cell.detailTextLabel?.numberOfLines = 3
        
        cell.textLabel?.text = thisWeight.nombre + " - " + thisWeight.direccion

        cell.detailTextLabel?.text = "(" + thisWeight.fecha + ")" + " Pedido : "  + thisWeight.pedido
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        //delete object from entity, remove from list
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Pedidos")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = context?.executeFetchRequest(request, error: nil) as NSArray!
        
        //Get value that is being deeleted
        let tmpObject: NSManagedObject = results[indexPath.row] as NSManagedObject
        let delWeight = tmpObject.valueForKey("nombre") as? String
        
        
        context?.deleteObject(results[indexPath.row] as NSManagedObject)
        context?.save(nil)
        totalEntries = totalEntries - 1
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
       
    }
 

}
