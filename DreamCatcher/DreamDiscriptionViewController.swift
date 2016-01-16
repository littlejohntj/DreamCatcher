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
        addGradientBackgroundLayer()
        addBlurEffect()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        
    }
    
    func addBlurEffect() {
        // Add blur view
        let bounds = self.navigationController?.navigationBar.bounds as CGRect!
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        
        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in above code to add effects to custom view.
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
    
    func addGradientBackgroundLayer() {
        let gradientLayer = CAGradientLayer()
        let height = view.frame.height
        let width = view.frame.width
        let startX = view.frame.origin.x
        let startY = view.frame.origin.y
        let newPoint = CGPoint(x: startX, y: startY - 100.0)
        let size = CGSize(width: width, height: height + 20.0)
        let frame = CGRect(origin: newPoint, size: size)
        gradientLayer.frame = frame
        
        let colorTop: AnyObject = UIColor(red: 73.0/255.0, green: 223.0/255.0, blue: 185.0/255.0, alpha: 1.0).CGColor
        let colorBottom: AnyObject = UIColor(red: 36.0/255.0, green: 115.0/255.0, blue: 192.0/255.0, alpha: 1.0).CGColor
        gradientLayer.colors = [colorTop, colorBottom]
        
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
