//
//  DBManager.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {
    
    //数据库操作的对象
    var ctx: NSManagedObjectContext?
    
    //单例对象
    static let manager = DBManager()
    
    
    //获取单例对象
    class func sharedManager() -> DBManager {
        return self.manager
    }
    
    
    private override init() {
        
        super.init()
        self.createContext()
    }
    
    //初始化数据库操作对象
    func createContext() -> Void {
        //模型对象文件
        let path = NSBundle.mainBundle().pathForResource("Collect", ofType: "momd")
        let url = NSURL(fileURLWithPath: path!)
        let model = NSManagedObjectModel(contentsOfURL: url)
        
        //关联数据库文件
        let coor = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        //数据库文件的路径
        let dataPath = NSHomeDirectory().stringByAppendingString("/Documents/collect.sqlite")
        let dataBaseUrl = NSURL(fileURLWithPath: dataPath)
        try! coor.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: dataBaseUrl, options: nil)
        
        //创建上下文对象
        self.ctx = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        self.ctx?.persistentStoreCoordinator = coor
    }
    
    //是否收藏
    func isInfoCollect(infoId: NSNumber) -> Bool {
    
        let entity = NSEntityDescription.entityForName("CollectModel", inManagedObjectContext: self.ctx!)
        let request = NSFetchRequest()
        request.entity = entity
        
        //设置查询条件        
        let predict = NSPredicate(format: "infoId == %@", infoId)
        request.predicate = predict
        
        let results = try! self.ctx?.executeFetchRequest(request)
        var ret = false
        if results?.count > 0 {
            ret = true
        }
        
        return ret
    }
    
    //收藏
    func addCollect(dict: Dictionary<String,AnyObject>) {
        
        
        
        //判断是否已经收藏
        
        let ret = self.isInfoCollect((dict[kInfoId] as? NSNumber)!)
        if ret == true {
            return
        }
        
        
        let entity = NSEntityDescription.insertNewObjectForEntityForName("CollectModel", inManagedObjectContext: self.ctx!) as! CollectModel
        if (dict.keys.contains(kCId)) {
            entity.cId = dict[kCId] as? NSNumber
        }
        if (dict.keys.contains(kInfoId)) {
            entity.infoId = dict[kInfoId] as? NSNumber
        }
        if (dict.keys.contains(kHeadImageUrl)) {
            entity.headImageUrl = dict[kHeadImageUrl] as? String
        }
        if (dict.keys.contains(kTitle)) {
            entity.title = dict[kTitle] as? String
        }
        if (dict.keys.contains(kDate)) {
            entity.date = dict[kDate] as? String
        }
        if (dict.keys.contains(kCommentCount)) {
            entity.commentCount = dict[kCommentCount] as? NSNumber
        }
        
        //保存
        try! self.ctx?.save()
        
        
    }
    
    //删除
    func deleteModel(infoId: NSNumber) {
        
        let entity = NSEntityDescription.entityForName("CollectModel", inManagedObjectContext: self.ctx!)
        let request = NSFetchRequest()
        request.entity = entity
        
        //设置查询条件
        let predict = NSPredicate(format: "infoId == %@", infoId)
        request.predicate = predict
        
        let results = try! self.ctx?.executeFetchRequest(request)
        
        if results?.count > 0 {
            let model = results?.first as? CollectModel
            
            self.ctx?.deleteObject(model!)
            
            //保存
            try! self.ctx?.save()
        }
        
        
        
    }
    
    
    //查询
    func searchAllCollects() -> [CollectModel]? {
        
        //创建查询对象
        let entity = NSEntityDescription.entityForName("CollectModel", inManagedObjectContext: self.ctx!)
        let request = NSFetchRequest()
        request.entity = entity
        
        
        //查询结果
        let results = try! self.ctx?.executeFetchRequest(request) as! [CollectModel]
        
        return results
    }
    

}
