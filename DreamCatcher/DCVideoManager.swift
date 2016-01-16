//
//  DCVideoManager.swift
//  DreamCatcher
//
//  Created by Todd Littlejohn on 1/16/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import Foundation

class DCVideoManager {
    
    var persistantArrayOfVideos:[NSDictionary] = [NSDictionary]()
    
    var arrayOfVideos:[DCVideo] = [DCVideo]()
    
    var persistantActivity = Dictionary<String,NSObject>()
    
    init () {
        
    }
    
    func addVideo(video: DCVideo) {
        arrayOfVideos.append(video)
    }
    
    func addVideoAndReturnNewArray(video:DCVideo) -> [DCVideo] {
        arrayOfVideos.append(video)
        return arrayOfVideos
    }
    
    func getArrayOfVideos() -> [DCVideo] {
        return self.arrayOfVideos
    }
    
    func removeVideoAtIndex(index: Int) {
        arrayOfVideos.removeAtIndex(index)
        saveApplicationData()
    }
    
    func updateArrayWith(array: [DCVideo]) {
        self.arrayOfVideos = array
        saveApplicationData()
    }
    
    func getLastIndexSpot() -> Int {
        let count = arrayOfVideos.count
        let incrementedCount = count - 1
        if incrementedCount < 0 {
            return 0
        }
        return count - 1
    }
    
    
    func saveApplicationData() {
        
        var persistantArrayOfVideos:[NSDictionary] = [NSDictionary]()
        
        var persistantVideo = Dictionary<String,String>()
        
        for video in arrayOfVideos {
            
            // Get basic data to be saved in the dictionary
            
            let videoURL = video.getVideoUrlAsString()
            
            let videoThumbNail = video.getVideoThumbNailUrlAsString()
            
            let dreamText = video.getDreamText()
            
            // Map the array of sessions into a dictionary
            
            persistantVideo["videoUrl"] = videoURL
            
            persistantVideo["videoThumbnail"] = videoThumbNail
            
            persistantVideo["dreamText"] = dreamText
            
            // Add the acitivty to the array
            persistantArrayOfVideos.append(persistantVideo)
            
        } // End of large for loop
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(persistantArrayOfVideos, forKey: "arrayOfVideos")
        
        defaults.synchronize()
        
        print("DONE SAVING")
        
    } // End of saveApplicationData function
    
    func loadApplicationData() {
        
        arrayOfVideos.removeAll(keepCapacity: false)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let persistantArrayOfVideos = defaults.objectForKey("arrayOfVideos") as? [NSDictionary]
        
        if persistantArrayOfVideos != nil {
            
            for video in persistantArrayOfVideos! {
                
                let newVideoUrl = video["videoUrl"] as! String
                
                let newVideoThumbnail = video["videoThumbnail"] as! String
                
                let newDreamText = video["dreamText"] as! String
                
                let tempVideo = DCVideo(videoString: newVideoUrl, thumbNail: newVideoThumbnail, text: newDreamText)
                
                arrayOfVideos.append(tempVideo)
                
            }// End of large for loop
        }
    }
}