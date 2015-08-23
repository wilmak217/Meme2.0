//
//  MemeEditorViewController.swift
//  ImageLoader
//
//  Created by Markus Willburn on 8/8/15.
//  Copyright (c) 2015 Markus Willburn. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var pickPhotoFromLibrary: UIBarButtonItem!
    
    // object variable declaration to initiate save capability
    var enableSave = false
    /*var dateStamp = NSDate()*/
    var memeToSave : GenMeme! // Meme struct object variable declaration
    var memedImage :  UIImage! // Meme image object variable declaration
    
    // Variable assignment of UITextField Font type and style parameters to be used by initializeMemeEditableParameters method
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 3.0]
    
    //Initialization of MemeEditorViewController UI View
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        /*Set UITextfields default text font style, visual and alignment settings where font style
        is defined in class level variable assignment*/
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .Center
        topTextField.text = "Top"
        bottomTextField.text = "Bottom"
        bottomTextField.textAlignment = .Center
        
        //Disable of both the Share (Activity View Controller)
        shareButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func pickedAnImageFromCamera(sender: AnyObject) {
        
        if  cameraButton.enabled != false{
   
         let imagePickedFromCamera = UIImagePickerController()
         imagePickedFromCamera.delegate = self
         imagePickedFromCamera.sourceType = UIImagePickerControllerSourceType.Camera
         presentViewController(imagePickedFromCamera, animated: true, completion: nil)
            
        }
            
        else{
            
            noCamera()
            
        }
    }
    
    @IBAction func cancelMeme(sender: AnyObject) {
        
        topTextField.text = "Top"
        bottomTextField.text = "Bottom"
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func textFieldEditor(sender: AnyObject) {
        
        switch(sender.tag){
            
        case 1:
            
            topTextField.delegate = self
            
        case 2:
            
            bottomTextField.delegate = self
            
        
        default:
            return
        }
        
        
    }
    
    @IBAction func memeSharing(sender: AnyObject) {
        
        enableSave = true
        
        /* Declaration of an Activity View Controller, (a view controller that allows for you to SMS, Email, Facebook, Twitter, etc functionality)*/
        let toShareAMeme = generationOfMemedImage()
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [toShareAMeme], applicationActivities: nil)
        
        // To Save images after sharing
        memeToSave = save()
        
        presentViewController(activityViewController, animated: true, completion: nil)

    }
    
    
    // Begin of local methods declarations
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[NSObject : AnyObject]){
        
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                
                imagePickerView.image = image
                imagePickerView.contentMode = .ScaleAspectFit

                
                dismissViewControllerAnimated(true, completion: nil)
                
                
                
                //Initially shows TextFields content after selection of photo is chosen
                topTextField.hidden = false
                bottomTextField.hidden = false
                
            }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
    
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "No camera found on current device", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        
        if topTextField.text == "Top" || bottomTextField.text == "Bottom" {
            
            textField.text = " "
         
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField){
    
        if (topTextField.text != "Top" && bottomTextField.text != "Bottom") && (topTextField.text != " " && bottomTextField != " ") {
            
            shareButton.enabled = true
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    func keyboardAnimatedShiftAppear(notification: NSNotification){
        
        //Position and Height of bottomTextField
        var bottomOrigin = bottomTextField.frame.origin.y
        
        if bottomTextField.isFirstResponder() {
            
            view.frame.origin.y -= getKeyboardHeight(notification)
        }

    }
    
    func keyboardAnimatedShiftDisappear(notification: NSNotification){
        
        if bottomTextField.isFirstResponder(){
            
            view.frame.origin.y += getKeyboardHeight(notification)
        }


    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        
        //Position and Height of bottomTextField
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
        
    }
    
    func subscribeToKeyboardNotifications(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardAnimatedShiftAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardAnimatedShiftDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    
    }
    
    func unsubscribeFromKeyboardNotifications(){
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func generationOfMemedImage() -> UIImage {
        //To Hide both the Bottom ToolBar and Top Navigation Bar
        navigationController!.setNavigationBarHidden(true, animated: true)
        
        tabBarController?.tabBar.hidden = true
        
        // Provides a view of image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // To Show both the Bottom ToolBar and Top Navigation Bar
        navigationController!.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.hidden = false
        
        return memedImage
    }
    
    func save() -> GenMeme{
        let meme =  GenMeme(textHeader: topTextField.text, textFootNote: bottomTextField.text, pickedImage: imagePickerView.image, memedImage: memedImage)
        
        //Add the saved meme to the memes Array specified on the Application Delegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
        /*dismissViewControllerAnimated(true, completion: nil)*/
        
        return meme
    }
    

}


