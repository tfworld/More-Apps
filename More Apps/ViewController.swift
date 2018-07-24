//
//  ViewController.swift
//  More Apps
//
//  Created by David Johnson on 7/17/18.
//  Copyright © 2018 TFWorld Software. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}

class ViewController: UICollectionViewController {

    var arrRes = [[String:AnyObject]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("http://www.tfworld.com/moregames/apps.php").responseJSON { responseData in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["apps"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                
                if self.arrRes.count > 0 {
                    self.collectionView?.reloadData()
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> MAItem {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "maItem",
                                                      for: indexPath) as! MAItem
        cell.backgroundColor = UIColor(red: 0.929, green: 0.941, blue: 0.945, alpha: 1.0)
        cell.title.text = self.arrRes[indexPath.row]["name"] as? String
        cell.descriptionText.text = self.arrRes[indexPath.row]["description"] as? String
        let imageString = self.arrRes[indexPath.row]["image"] as! String
        cell.icon.af_setImage(withURL: URL(string: "http://www.tfworld.com/moregames/"+imageString)!)
        cell.link = URL(string:self.arrRes[indexPath.row]["link"] as! String)!
        // Configure the cell

        
        return cell
    }
    
    func loadImage( _ index: Int ) {
        
        
        for item in self.arrRes {
            let iconURL = item["icon"] as! String
                
            Alamofire.request(iconURL).responseImage { response in
                    
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string:self.arrRes[indexPath.row]["link"] as! String) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }

}

