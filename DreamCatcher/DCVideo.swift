//
//  DCVideo.swift
//  DreamCatcher
//
//  Created by Todd Littlejohn on 1/16/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import Foundation

class DCVideo {
    
    var videoURL:String!
    var videoThumbNailURL:String!
    var dreamText:String!
    
    init(videoString: String, thumbNail:String, text: String) {
        self.videoURL = videoString
        self.videoThumbNailURL = thumbNail
        self.dreamText = text
    }
    
    func getVideoUrlAsString() -> String {
        return self.videoURL
    }
    
    func getVideoThumbNailUrlAsString() -> String {
        return self.videoThumbNailURL
    }
    
    func getVideoUrlAsUrl() -> NSURL {
        let url = NSURL(string: self.videoURL)
        return url!
    }
    
    func getVideoThumbNailUrlAsUrl() -> NSURL {
        let url = NSURL(string: self.videoThumbNailURL)
        return url!
    }
    
    func getDreamText() -> String {
        return self.dreamText
    }
    
    
}