//
//  SavedMemeSelectionViewer.swift
//  Meme
//
//  Created by Markus Willburn on 8/21/15.
//  Copyright (c) 2015 Markus Willburn. All rights reserved.
//

import UIKit

class SavedMemeSelectionViewer : UIViewController {

    var showMemeDetail: GenMeme!
    
    @IBOutlet weak var selectedFromSentMemes: UIImageView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedFromSentMemes.image = showMemeDetail.memedImage

    }

}
