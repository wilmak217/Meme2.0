//
//  SentMemesTableViewController.swift
//  Meme
//
//  Created by Markus Willburn on 8/20/15.
//  Copyright (c) 2015 Markus Willburn. All rights reserved.
//

import UIKit

class SentMemesTableViewController : UITableViewController {
    
    @IBOutlet weak var memeEditButton: UIBarButtonItem!
    
    var memes: [GenMeme]!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        
        memeEditButton.enabled = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        tabBarController!.tabBar.hidden = true
        tableView!.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MemeTable") as! UITableViewCell
        
        var tableMeme = memes[indexPath.row]
        
        cell.textLabel!.text = tableMeme.textHeader + "_" + tableMeme.textFootNote
        cell.imageView!.image = tableMeme.pickedImage
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Get a SentMemesTableViewController from the Storyboard
        let sentMemeController = storyboard!.instantiateViewControllerWithIdentifier("SavedMemeSelectionViewer") as! SavedMemeSelectionViewer
        
        //Retrieve the selected meme based on method call
        let selectedMeme =  memes[indexPath.row]
        sentMemeController.showMemeDetail = selectedMeme
        
        // Push the new controller onto the stack
        navigationController!.pushViewController(sentMemeController, animated: true)
        
        // Upon pressing Edit button, change the Bar Button to a Trash can and past the action to memeEdit
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "memeEdit:")
        
        tabBarController?.tabBar.hidden = false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == UITableViewCellEditingStyle.Delete {
                
                
                let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                memes = applicationDelegate.memes
                memes.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func memeEdit(sender: AnyObject) {
        

        
    }
    
}