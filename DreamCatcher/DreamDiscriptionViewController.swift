//
//  DreamDiscriptionViewController.swift
//  DreamCatcher
//
//  Created by Todd Littlejohn on 1/16/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import UIKit
import Alamofire

class DreamDiscriptionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dreamDescriptionTextView: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func send(sender: AnyObject) {
        
        if dreamDescriptionTextView.text.characters.count > 0 {
        
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["dream": "\(dreamDescriptionTextView.text)"])
            .responseJSON { response in
                
                var newVideoUrl = "http://104.236.30.131/2_to_4.mp4"
                
                var newThumbNailUrl = "image1"
                
                let newVideo = DCVideo(videoString: newVideoUrl, thumbNail: newThumbNailUrl)
                
                globalDCVideoManager.addVideo(newVideo)
                
                globalDCVideoManager.saveApplicationData()
                
                videoUrl = NSURL(string: newVideoUrl)!
                
                self.performSegueWithIdentifier("toPlayerFromDescription", sender: self)
                
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let tempString:NSString = text as NSString
        
        if tempString.isEqualToString("\n") {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
