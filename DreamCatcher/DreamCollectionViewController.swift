//
//  DreamCollectionViewController.swift
//  DreamCatcher
//
//  Created by Todd Littlejohn on 1/16/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import UIKit
import Kingfisher
import Glyptodon

var globalDCVideoManager = DCVideoManager()

class DreamCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayOfVideos:[DCVideo] = [DCVideo]()
    
    var collectionViewLayout: RACollectionViewReorderableTripletLayout!
    
    @IBOutlet var collectionViewContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let welcomeViewController:WelcomeViewController = WelcomeViewController()
        self.presentViewController(welcomeViewController, animated: false, completion: nil)
        
        // Setting Navigation Bar Color
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        // Setting Navigation Bar Title
        self.navigationItem.title = "Dreamcatcher"
        self.navigationController?.navigationBar.barTintColor = UIColor.colorFromHex(0x0C1232)
        // Setting Up Collection View 
        collectionViewLayout = RACollectionViewReorderableTripletLayout()
        
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .whiteColor()
        
        globalDCVideoManager.loadApplicationData()
        arrayOfVideos = globalDCVideoManager.getArrayOfVideos()
        
        
        checkForContent()
        
    }
    
    func checkForContent() {
        if arrayOfVideos.count == 0 {
            self.collectionView.alpha = 0.0
            self.collectionViewContainerView.glyptodon.show("Tell me your dreams.")
        } else {
            self.collectionView.alpha = 1.0
            self.collectionViewContainerView.glyptodon.hide()
            
        }
    }
    
    func sectionSpacingForCollectionView(collectionView: UICollectionView!) -> CGFloat {
        return 5.0
    }
    
    func minimumInteritemSpacingForCollectionView(collectionView: UICollectionView!) -> CGFloat {
        return 5.0
    }
    
    func minimumLineSpacingForCollectionView(collectionView: UICollectionView!) -> CGFloat {
        return 5.0
    }
    
    func insetsForCollectionView(collectionView: UICollectionView!) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5.0, 0.0, 5.0, 0.0)
    }
    
    func autoScrollTrigerEdgeInsets(collectionView: UICollectionView!) -> UIEdgeInsets {
        return UIEdgeInsetsMake(50.0, 0.0, 50.0, 0)
    }
    
    func autoScrollTrigerPadding(collectionView: UICollectionView!) -> UIEdgeInsets {
        return UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0)
    }
    
    func reorderingItemAlpha(collectionview: UICollectionView!) -> CGFloat {
        return 0.3
    }
    
    
    
    
    // MARK: Actions
    
    @IBAction func addNewDream(sender: AnyObject) {
        self.performSegueWithIdentifier("lego", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        globalDCVideoManager.loadApplicationData()
        arrayOfVideos = globalDCVideoManager.getArrayOfVideos()
        collectionView.reloadData()
        checkForContent()
    }
    
    // MARK: Collection View Functions
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfVideos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let video = arrayOfVideos[indexPath.row]
        cell.imageView.kf_setImageWithURL(NSURL(string: video.getVideoThumbNailUrlAsString())!, placeholderImage: nil)
        print(video.getVideoThumbNailUrlAsString())
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toVideoPlayer" {
            let cellIndexPathRow = collectionView.indexPathForCell(sender! as! ImageCollectionViewCell)!
            let videoToPlay:DCVideo = arrayOfVideos[cellIndexPathRow.row]
            currentDream = videoToPlay
            currentDreamIndex = cellIndexPathRow.row
            videoUrl = videoToPlay.getVideoUrlAsUrl()
        }
    }
    
    
    
//    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
//        
//        if gestureReconizer.state == UIGestureRecognizerState.Began {
//                        let location = gestureReconizer.locationInView(self.view)
//                        print(location)
//                        let index = collectionView.indexPathForItemAtPoint(location)
//                        print(self.collectionView.frame.width)
//                        print(index)
////            
//        }
//        
//    }
//
//    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


extension DreamCollectionViewController: RACollectionViewDelegateReorderableTripletLayout {
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, didEndDraggingItemAtIndexPath indexPath: NSIndexPath!) {
        self.collectionView.reloadData()
    }
    
}

extension DreamCollectionViewController: RACollectionViewReorderableTripletLayoutDataSource {
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView!, itemAtIndexPath fromIndexPath: NSIndexPath!, canMoveToIndexPath toIndexPath: NSIndexPath!) -> Bool {
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView!, itemAtIndexPath fromIndexPath: NSIndexPath!, willMoveToIndexPath toIndexPath: NSIndexPath!) {
        // leave this open
    }
    
    func collectionView(collectionView: UICollectionView!, itemAtIndexPath fromIndexPath: NSIndexPath!, didMoveToIndexPath toIndexPath: NSIndexPath!) {
        
        let video = arrayOfVideos[fromIndexPath.row]
        arrayOfVideos.removeAtIndex(fromIndexPath.item)
        arrayOfVideos.insert(video, atIndex: toIndexPath.item)
        globalDCVideoManager.updateArrayWith(self.arrayOfVideos)
    }
    
    
    
    
}