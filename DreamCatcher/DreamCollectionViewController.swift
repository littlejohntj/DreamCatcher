//
//  DreamCollectionViewController.swift
//  DreamCatcher
//
//  Created by Todd Littlejohn on 1/16/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import UIKit
import Kingfisher

var globalDCVideoManager = DCVideoManager()

class DreamCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayOfVideos:[DCVideo] = [DCVideo]()
    
    var collectionViewLayout: RACollectionViewReorderableTripletLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting Navigation Bar Color
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        // Setting Navigation Bar Title
        self.navigationItem.title = "Dream Catcher"
        
        // Setting Up Collection View 
        collectionViewLayout = RACollectionViewReorderableTripletLayout()
        
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .whiteColor()
        
        globalDCVideoManager.loadApplicationData()
        arrayOfVideos = globalDCVideoManager.getArrayOfVideos()
        
        // Set up gesture 
        
//        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
//        lpgr.minimumPressDuration = 0.5
//        lpgr.delaysTouchesBegan = true
//        lpgr.delegate = self
//        self.collectionView.addGestureRecognizer(lpgr)
        
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
//                        let alertController = UIAlertController(title: "Delete Dream", message:
//                            "Are you sure you want to forget this dream?", preferredStyle: UIAlertControllerStyle.Alert)
//                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//                        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
//                            
//                            globalDCVideoManager.removeVideoAtIndex((index?.row)!)
//                            self.arrayOfVideos = globalDCVideoManager.getArrayOfVideos()
//                            self.collectionView.reloadData()
//                            
//                        })
//                        alertController.addAction(cancelAction)
//                        alertController.addAction(deleteAction)
//                        //        alertController.view.tintColor = UIColor._hackRed()
//                        self.presentViewController(alertController, animated: true, completion: nil)
//        }
//        
//    }

    
    
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