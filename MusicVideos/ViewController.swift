//
//  ViewController.swift
//  MusicVideos
//
//  Created by Milen Chavdarov on 3/11/16.
//  Copyright © 2016 Milen Chavdarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        //call API
        let api = APIManager()
        api.loadData(
                      "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"
                      ,completion: didLoadData
                    )
    }
    
    func didLoadData( videos: [Videos] ) {
    
        for ( index, item ) in videos.enumerate() {
            print( "\( index ) name - \(item.vName)" )
        }
        
    }
    
//    func didLoadData( result: String ) {
//        let alert = UIAlertController( title: ( result ), message: nil, preferredStyle: .Alert )
//        
//        let okAction = UIAlertAction( title: "OK", style: .Default ) {
//            action -> Void in
//        }
//        
//        alert.addAction( okAction )
//        self.presentViewController( alert, animated: true, completion: nil )
//    }
}