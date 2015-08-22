//
//  SentMemesTableViewController.swift
//  Meme
//
//  Created by Markus Willburn on 8/20/15.
//  Copyright (c) 2015 Markus Willburn. All rights reserved.
//

import UIKit

class SentMemesTableViewController : UITableViewController {
    
    var memes: [GenMeme]!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        tableView!.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("MemeTable") as! UITableViewCell
        var tableMeme = memes[indexPath.row]
        
        cell.textLabel!.text = tableMeme.textHeader + "_" + tableMeme.textFootNote
        cell.imageView!.image = tableMeme.pickedImage
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Retrieve the selected meme based on method call
        let selectedMeme =  memes[indexPath.row].memedImage
        
        //Get a SentMemesTableViewController from the Storyboard
        let sentMemeController = self.storyboard!.instantiateViewControllerWithIdentifier("SentMemesTableViewController") as! SentMemesTableViewController
        
        // Push the new controller onto the stack
        self.navigationController!.pushViewController(sentMemeController, animated: true)
        
    }

}