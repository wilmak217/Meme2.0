//
//  SentMemesCollectionViewController.swift
//  Meme
//
//  Created by Markus Willburn on 8/21/15.
//  Copyright (c) 2015 Markus Willburn. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController : UICollectionViewController, UICollectionViewDataSource{

    var memes: [GenMeme]!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad(){
        super.viewDidLoad()
    
        let space: CGFloat = 2.5
        let wDim = (self.view.frame.size.width - (2 * space)) / 3.0
        let hDim = (self.view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(wDim, hDim)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.tabBar.hidden = false
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        collectionView!.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.memes.count
    
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let collectionMeme = memes[indexPath.item]
        
        cell.topText.text = collectionMeme.textHeader
        
        cell.collectionView!.image = collectionMeme.pickedImage
        
        cell.bottomText.text = collectionMeme.textFootNote
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath){
    
    
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("SavedMemeSelectionViewer") as! SavedMemeSelectionViewer
        
        
        /*detailController.meme = self.memes[indexPath.row]*/
        
        self.navigationController!.pushViewController(detailController, animated: true)
    
    }
    
}
