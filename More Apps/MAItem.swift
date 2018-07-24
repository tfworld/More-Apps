//
//  MAItem.swift
//  More Apps
//
//  Created by David Johnson on 7/17/18.
//  Copyright © 2018 TFWorld Software. All rights reserved.
//

import UIKit

class MAItem : UICollectionViewCell {
    
    @IBOutlet var icon:UIImageView!
    @IBOutlet var title:UILabel!
    @IBOutlet var descriptionText:UITextView!
    
    var link:URL = URL(string: "http://www.tfworld.com")!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layer.cornerRadius = 12.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 12.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}
