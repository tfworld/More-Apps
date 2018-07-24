//
//  MoreApps.swift
//  More Apps
//
//  Created by David Johnson on 7/17/18.
//  Copyright © 2018 TFWorld Software. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MoreApps {
    
    var size:CGSize = .zero
    var arrRes = [[String:AnyObject]]()
    
    func setup( _ size:CGSize ) {
        self.size = size
        
        self.isUserInteractionEnabled = true
        
        //start loading via JSON file
        
        Alamofire.request("http://www.tfworld.com/moregames/apps.php").responseJSON {
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["apps"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            }
        }
        
        let json = JSON(data:fromNetworking)
        if let username = json[0]["user"]["name"].string {
            print("username: \(username)")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in:self)
        if let node = self.atPoint(location) as? MAItem {
            print("touchesBegan")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in:self)
        if let node = self.atPoint(location) as? MAItem {
            if let name = node.name {
                print("node: \(name)")
            }
        }
    }
}
