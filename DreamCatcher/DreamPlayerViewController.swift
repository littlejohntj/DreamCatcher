//  ViewController.swift
//
//  Created by patrick piemonte on 11/26/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-present patrick piemonte (http://patrickpiemonte.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import AssetsLibrary

var videoUrl = NSURL(string: "https://v.cdn.vine.co/r/videos/AA3C120C521177175800441692160_38f2cbd1ffb.1.5.13763579289575020226.mp4")

var currentDream:DCVideo!

var currentDreamIndex:Int!

class DreamPlayerViewController: UIViewController, PlayerDelegate {
    @IBOutlet weak var pauseImage: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var dreamTextView: UITextView!
    
    
    private var player: Player!
    var heartAnimating:Bool = false
    var count = 0
    var timer = NSTimer()
    
    // MARK: object lifecycle
    
    convenience init() {
        self.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pauseImage.alpha = 0.0
        self.activityIndicator.startAnimating()
        self.view.autoresizingMask = ([UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight])
        
        dreamTextView.contentOffset = CGPointMake(0, -220)
        
        
        
        self.player = Player()
        self.player.delegate = self
        self.player.view.frame = self.view.bounds
        
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        
        self.player.setUrl(videoUrl!)
        self.player.playbackLoops = true
        self.view.bringSubviewToFront(pauseImage)
        self.view.bringSubviewToFront(dreamTextView)
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGestureRecognizer:")
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
        self.dreamTextView.text = currentDream.getDreamText()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playFromBeginning()
    }
    
    // MARK: UIGestureRecognizer
    
    func handleTapGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.Stopped.rawValue:
            self.player.playFromBeginning()
        case PlaybackState.Paused.rawValue:
            self.player.playFromCurrentTime()
        case PlaybackState.Playing.rawValue:
            self.player.pause()
            print("pause")
            animatePause()
        case PlaybackState.Failed.rawValue:
            self.player.pause()
            print("pause")
            animatePause()
        default:
            self.player.pause()
            print("pause")
            animatePause()
        }
    }
    
    // MARK: Animation Handling 
    
    func animatePause() {
        if heartAnimating == false {
            heartAnimating = true
            
            pauseImage.alpha = 1.0
            timer =  NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("counting"), userInfo: nil, repeats: true)
        }
    }

    @IBAction func handleActions(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Delete", message:
            "Are you sure you want to delete?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            
            globalDCVideoManager.removeVideoAtIndex(currentDreamIndex)
            self.navigationController?.popViewControllerAnimated(true)
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        //        alertController.view.tintColor = UIColor._hackRed()
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    func counting() {
        count++
        if count >= 50 {
            pauseImage.alpha = pauseImage.alpha - 0.02
        }
        
        if count == 100 {
            timer.invalidate()
            heartAnimating = false
            count = 0
        }
    }
    
    // MARK: Actions 
    
    @IBAction func shareButton(sender: AnyObject) {
        
    }
    
    
    // MARK: PlayerDelegate
    
    func playerReady(player: Player) {
    }
    
    func playerPlaybackStateDidChange(player: Player) {
    }
    
    func playerBufferingStateDidChange(player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
    }
    
    func playerPlaybackDidEnd(player: Player) {
    }
    
}

