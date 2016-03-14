//
//  ViewController.swift
//  MusicVideos
//
//  Created by Milen Chavdarov on 3/11/16.
//  Copyright © 2016 Milen Chavdarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "reachabilityStatusChanged",
            name: "ReachStatusChanged",
            object: nil )
        
        reachabilityStatusChanged()
        
        //call API
        let api = APIManager()
        api.loadData(
                      "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"
                      ,completion: didLoadData
                    )
    }
    
    func didLoadData( videos: [Videos] ) {
    
        print( reachabilityStatus )
        self.videos = videos
        
        for ( index, item ) in videos.enumerate() {
            print( "\( index ) name - \(item.vName)" )
        }
        
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
}