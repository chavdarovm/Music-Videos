//
//  APIManager.swift
//  MusicVideos
//
//  Created by Milen Chavdarov on 3/11/16.
//  Copyright © 2016 Milen Chavdarov. All rights reserved.
//

import Foundation

class APIManager {

    func loadData( urlString: String, completion: /*( result: String )*/ [Videos] -> Void ) {
    
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession( configuration: config )
        //let session = NSURLSession.sharedSession()
        let url = NSURL( string: urlString )!
        
        let task = session.dataTaskWithURL( url ) {
            ( data, response, error ) -> Void in
            
            if error != nil {
                    print( error!.localizedDescription )
            } else {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(
                                                                        data!,
                                                                        options: .AllowFragments
                                                                        ) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray {
                        
                            var videos = [Videos]()
                            for entry in entries {
                                let entry = Videos(data: entry as! JSONDictionary)
                                videos.append( entry )
                            }
                        
                            let i = videos.count
                            print( "iTunesAPI Manager - total count -> \(i)" )  //@@
                            print( "   " )                                      //@@
                            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                            dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                                dispatch_async( dispatch_get_main_queue() ) {
                                    completion(videos)
                                }
                            }
                    }
                } catch {
                        print ( "error in JSONSerialization" )
                }
            }
        }
        task.resume()
    }
}