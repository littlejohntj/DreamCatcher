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
    
    init(videoString: String, thumbNail:String) {
        self.videoURL = videoString
        self.videoThumbNailURL = thumbNail
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
}