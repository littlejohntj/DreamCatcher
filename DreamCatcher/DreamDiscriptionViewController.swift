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
    
    @IBOutlet weak var dreamLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.dreamDescriptionTextView.layer.borderColor = UIColor.whiteColor().CGColor
        self.dreamDescriptionTextView.clipsToBounds = true
        self.dreamDescriptionTextView.layer.borderWidth = 2.0
        self.dreamDescriptionTextView.layer.cornerRadius = 10.0
        
        self.sendButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.sendButton.clipsToBounds = true
        self.sendButton.layer.borderWidth = 2.0
        self.sendButton.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func send(sender: AnyObject) {
        
        if dreamDescriptionTextView.text!.characters.count > 0 {
        
        Alamofire.request(.GET, "http://2cc725cc.ngrok.io/api/dreamText", parameters: ["dream": "\(dreamDescriptionTextView.text)"])
            .responseJSON { response in
                
                print(response.request!)  // original URL request
                print(response.response!) // URL response
                print(response.data!)     // server data
                print(response)   // result of response serialization
                
                if let json = response.result.value {
                    
                    let jsonDict = json as! NSDictionary
                    let videoString = jsonDict["video"] as! String
                    let imageString = jsonDict["image"] as! String
                    let dreamText = self.dreamDescriptionTextView.text
                    let newVideoUrl = videoString
                    
                    let newThumbNailUrl = imageString
                    
                    let newVideo = DCVideo(videoString: newVideoUrl, thumbNail: newThumbNailUrl, text: dreamText)
                    
                    currentDream = newVideo
                    
                    globalDCVideoManager.addVideo(newVideo)
                    
                    globalDCVideoManager.saveApplicationData()
                    
                    currentDreamIndex = globalDCVideoManager.getLastIndexSpot()
                    
                    videoUrl = NSURL(string: newVideoUrl)!
                    
                    self.performSegueWithIdentifier("toPlayerFromDescription", sender: self)
                    
                    self.dreamDescriptionTextView.text = "  "

                    
                } else {
                    print("super not tight")
                }

                
                
//                print(response)
//                
                
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
