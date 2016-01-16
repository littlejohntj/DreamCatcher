//
//  DreamCollectionViewController.swift
//  DreamCatcher
//
//  Created by Todd Littlejohn on 1/16/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import UIKit

class DreamCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrayOfVideos:[DCVideo] = [DCVideo]()
    
    var collectionViewLayout: CustomImageFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting Navigation Bar Color
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Setting Navigation Bar Title
        self.navigationItem.title = "HACKFSU"
        
        // Setting Up Collection View 
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .whiteColor()
    }
    
    // MARK: Collection View Functions
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let imageName = (indexPath.row % 2 == 0) ? "image1" : "image2"
        
        cell.imageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toVideoPlayer" {
//            let cellIndexPathRow = collectionView.indexPathForCell(sender! as! ImageCollectionViewCell)!
//            let videoToPlay:DCVideo = arrayOfVideos[cellIndexPathRow.row]
//            let videoPlayerController:DreamPlayerViewController = segue.destinationViewController as! DreamPlayerViewController
//            videoPlayerController.url = videoToPlay.getVideoUrlAsUrl()
        }
        
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
