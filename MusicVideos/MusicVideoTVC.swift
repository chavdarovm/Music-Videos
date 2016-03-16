//
//  MusicVideoTVC.swift
//  MusicVideos
//
//  Created by Milen Chavdarov on 3/15/16.
//  Copyright © 2016 Milen Chavdarov. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "reachabilityStatusChanged",
            name: "ReachStatusChanged",
            object: nil )
        
        reachabilityStatusChanged()
    }
    
    func didLoadData( videos: [Videos] ) {
        
        self.videos = videos
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus{
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            //move back to main q ue
            dispatch_async( dispatch_get_main_queue() ) {
        
            let  alert = UIAlertController(
                title: "No Internet Access",
                message: "Please make sure you are connected to the Internet",
                preferredStyle: .Alert )
            
            let cancelAction = UIAlertAction( title: "Cancel", style: .Default ) {
                action -> () in
                print( "Cancel" )
            }
            
            let okAction = UIAlertAction( title: "Ok", style: .Default ) {
                action -> Void in
                print( "Ok" )
            }
        
            alert.addAction( cancelAction )
            alert.addAction( okAction )
            
            self.presentViewController( alert, animated: true, completion: nil)
            }
            default: view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh API" )
            } else {
                runAPI()
            }
        }
    }
    
    func runAPI() {
    
        //call API
        let api = APIManager()
        api.loadData(
            "https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json"
            ,completion: didLoadData
        )
    
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: "ReachStatusChanged",
            object: nil
        )
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ( "\(indexPath.row + 1)" )
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
