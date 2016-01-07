//
//  CollectViewController.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/26.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class CollectViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    //表格
    var tbView: UITableView?
    
    //数据源数组
    lazy var dataArray: NSMutableArray = NSMutableArray()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //返回按钮
        self.addNavBackBtn(self, action: "backAction")
        
        self.addNavTitle("我的收藏")
        
        
        self.createTableView()
        
        self.loadData()
        
    }
    
    
    func backAction() {
    
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //表格
    func createTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tbView = UITableView(frame: CGRectMake(0, 64, 375, 667-64-49), style: UITableViewStyle.Plain)
        self.tbView?.delegate = self
        self.tbView?.dataSource = self
        self.view.addSubview(self.tbView!)
        
    }
    
    //获取数据
    func loadData() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            
            
            let array = DBManager.sharedManager().searchAllCollects()
            
            if array?.count > 0 {
                self.dataArray .addObjectsFromArray(array!)
            }
            
            self.performSelectorOnMainThread("refreshData", withObject: nil, waitUntilDone: false)
            
            
        }
        
    }
    
    
    //刷新表格
    func refreshData() {
        self.tbView?.reloadData()
    }
    
    
    
    func backAction(btn: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CollectViewController {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "collectCellId"
        
        var cell: CollectCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? CollectCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CollectCell", owner: nil, options: nil).last as? CollectCell
        }

        let model = self.dataArray[indexPath.row] as? CollectModel
        cell?.configModel(model!)
        
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        

        //数据库删除
        let model = self.dataArray[indexPath.row] as! CollectModel
        DBManager.sharedManager().deleteModel(model.infoId!)
        
        //从数组删除
        self.dataArray.removeObjectAtIndex(indexPath.row)
        
        self.tbView?.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    
    
}

