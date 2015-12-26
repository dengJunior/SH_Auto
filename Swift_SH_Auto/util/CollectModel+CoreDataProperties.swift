//
//  CollectModel+CoreDataProperties.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/27.
//  Copyright © 2015年 apple. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

public let kCId = "cId"
public let kInfoId = "infoId"
public let kHeadImageUrl = "headImageUrl"
public let kTitle = "title"
public let kDate = "date"
public let kCommentCount = "commentCount"

extension CollectModel {

    @NSManaged var cId: NSNumber?
    @NSManaged var infoId: NSNumber?
    @NSManaged var headImageUrl: String?
    @NSManaged var title: String?
    @NSManaged var date: String?
    @NSManaged var commentCount: NSNumber?

}
