//
//  InfoModel.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class InfoModel: NSObject {
    
    var id: NSNumber = 0
    var createTime: String?
    var title: String?
    var header_img_url: String?
    var commentCount: NSNumber?
    var brief: String?
    

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
