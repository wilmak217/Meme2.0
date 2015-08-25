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
    
    @IBOutlet weak var memeEditButton: UIBarButtonItem!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad(){
        super.viewDidLoad()
    
        let space: CGFloat = 2.5
        let wDim = (view.frame.size.width - (2 * space)) / 3.0
        let hDim = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(wDim, hDim)
        
        memeEditButton.enabled = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.tabBar.hidden = true
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        collectionView!.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return memes.count
    
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let collectionMeme = memes[indexPath.row]
        cell.topText.text = collectionMeme.textHeader
        cell.collectionView?.image = collectionMeme.memedImage
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath){
    
    
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("SavedMemeSelectionViewer") as! SavedMemeSelectionViewer
        
        detailController.showMemeDetail = memes[indexPath.item]
        
        navigationController!.pushViewController(detailController, animated: true)
    
    }

    @IBAction func memeEdit(sender: AnyObject) {
        
        // Upon pressing Edit button, change the Bar Button to a Trash can and past the action to memeEdit
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "memeEdit:")
        
    }

    
}
