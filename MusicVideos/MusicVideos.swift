//
//  MusicVideos.swift
//  MusicVideos
//
//  Created by Milen Chavdarov on 3/13/16.
//  Copyright © 2016 Milen Chavdarov. All rights reserved.
//

import Foundation

class Videos {

    private var _vName:         String
    private var _vRights:       String
    private var _vPrice:        String
    private var _vImageUrl:     String
    private var _vArtist:       String
    private var _vVideoUrl:     String
    private var _vImid:         String
    private var _vGenre:        String
    private var _vLinkToiTunes: String
    private var _vReleaseDte:   String
    
    var vImageData: NSData?;
    
    //Make geters
    var vName:          String{ return _vName }
    var vRights:        String{ return _vRights }
    var vPrice:         String{ return _vPrice }
    var vImageUrl:      String{ return _vImageUrl }
    var vArtist:        String{ return _vArtist }
    var vVideoUrl:      String{ return _vVideoUrl }
    var vImId:          String{ return _vImid }
    var vGenre:         String{ return _vGenre }
    var vLinkToItunes:  String{ return _vLinkToiTunes }
    var vReleaseDate:   String{ return _vReleaseDte }
    
    init ( data: JSONDictionary ) {
    
        //Video NAme
        if let name = data["im:name"] as? JSONDictionary,
                vName = name["label"] as? String {
                    self._vName = vName
        } else{
            self._vName = ""
        }
        
        if let rights = data["rights"] as? JSONDictionary,
                vRights = rights["label"] as? String {
                    self._vRights = vRights
        } else {
            self._vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionary,
                prc = price["label"] as? String {
                    self._vPrice = prc
        } else {
            self._vPrice = ""
        }
        
        //Video Image
        if let img = data["im:image"] as? JSONArray,
                image = img[2] as? JSONDictionary,
                immage = image["label"] as? String {
                    self._vImageUrl = immage.stringByReplacingOccurrencesOfString( "100x100", withString: "600x600" )
        } else {
            self._vImageUrl = ""
        }
    
        if let artist = data["im:artist"] as? JSONDictionary,
                artLabel = artist["label"] as? String {
                    self._vArtist = artLabel
        } else {
            self._vArtist = ""
        }
        
        if let imid = data["id"] as? JSONDictionary,
            idAttrib = imid["attributes"] as? JSONDictionary,
            id = idAttrib["im:id"] as? String {
                self._vImid = id
        } else {
            self._vImid = ""
        }
        
        if let genr = data["category"] as? JSONDictionary,
                genrAttrib = genr["atributes"] as? JSONDictionary,
                genre = genrAttrib["term"] as? String {
                    self._vGenre = genre
        } else {
                self._vGenre = ""
        }
        
        if let relDte = data["im:releaseDate"] as? JSONDictionary,
            dteAttrib = relDte["attributes"] as? JSONDictionary,
            dte = dteAttrib["label"] as? String {
                _vReleaseDte = dte
        } else {
            _vReleaseDte = ""
        }
        
        //Video URL
        if let video = data["link"] as? JSONArray,
                vUrl = video[1] as? JSONDictionary,
                vHref = vUrl["attributes"] as? JSONDictionary,
                vVideoUrl = vHref["href"] as? String,
                viTunes = video[0] as? JSONDictionary,
                viTunees = viTunes["attributes"] as? JSONDictionary,
                viTuneees = viTunees["href"] as? String {
                    _vVideoUrl = vVideoUrl
                    _vLinkToiTunes = viTuneees
        } else {
            _vVideoUrl = ""
            _vLinkToiTunes = ""
        }
    }
}
