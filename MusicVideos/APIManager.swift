//
//  APIManager.swift
//  MusicVideos
//
//  Created by Milen Chavdarov on 3/11/16.
//  Copyright © 2016 Milen Chavdarov. All rights reserved.
//

import Foundation

class APIManager {

    func loadData( urlString: String, completion: ( result: String ) -> Void ) {
    
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession( configuration: config )
        //let session = NSURLSession.sharedSession()
        let url = NSURL( string: urlString )!
        
        let task = session.dataTaskWithURL( url ) {
            ( data, response, error ) -> Void in
            
            if error != nil {
                dispatch_async( dispatch_get_main_queue() ) {
                    completion( result: ( error!.localizedDescription ) )
                }
            } else { 
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(
                                                                        data!,
                                                                        options: .AllowFragments
                                                                        ) as? [ String: AnyObject ] {
                            print( json )
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                                dispatch_async( dispatch_get_main_queue() ) {
                                    completion( result: "JSON Serialization successful" )
                                }
                            }
                        }
                } catch {
                    dispatch_async( dispatch_get_main_queue() ) {
                        completion( result: "error in NSJasonSerialization" )
                    }
                }
            }
//            dispatch_async( dispatch_get_main_queue() ) {
//                if error != nil {
//                    completion( result: ( error!.localizedDescription ) )
//                } else {
//                    completion( result: "NSURLSession successful" )
//                    print( data )
//                }
//            }
        }
        task.resume()
    }
}