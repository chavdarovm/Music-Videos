//
//  ViewController.swift
//  MusicVideos
//
//  Created by Milen Chavdarov on 3/11/16.
//  Copyright © 2016 Milen Chavdarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "reachabilityStatusChanged",
            name: "ReachStatusChanged",
            object: nil )
        
        reachabilityStatusChanged()
        
        //call API
        let api = APIManager()
        api.loadData(
                      "https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json"
                      ,completion: didLoadData
                    )
    }
    
    func didLoadData( videos: [Videos] ) {
    
        print( reachabilityStatus )
        self.videos = videos
        
        for ( index, item ) in videos.enumerate() {
            print( "\( index ) name - \(item.vName)" )
        }
        
        tableView.reloadData()
        
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus{
        case NOACCESS: view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Riachable with Celluliar"
        default: return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: "ReachStatusChanged",
            object: nil
        )
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {// Default is 1 if not implemented
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier( "cell", forIndexPath: indexPath )
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ( "\(indexPath.row + 1)" )
        cell.detailTextLabel?.text = video.vName
    
        return cell
    }
}