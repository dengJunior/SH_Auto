//
//  InformationViewController.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class InformationViewController: BaseViewController ,UITableViewDelegate, UITableViewDataSource, MyDownloaderDelegate{
    
    
    //类型
    //默认是最新
    var newsType: String = "11"
    
    
    //数据源
    lazy var dataArray: NSMutableArray = NSMutableArray()
    
    //列表的lastId值
    var lastId: String = ""
    
    
    //表格
    var tbView: UITableView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //创建表格
        self.createTableView()
        
    }
    
    
    
    //创建表格
    func createTableView () {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    
        self.tbView = UITableView(frame: CGRectMake(0, 64+40, kScreenW, kScreenH-64-40-49), style: UITableViewStyle.Plain)
        self.tbView?.delegate = self
        self.tbView?.dataSource = self
        self.view.addSubview(self.tbView!)
        
        
        //下拉刷新
        self.tbView?.headerView = XWRefreshNormalHeader(target: self, action: "loadNew")
        
        //上拉加载更多
        self.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: "loadMore")
        
        self.tbView?.headerView?.beginRefreshing()
        
        
    }
    
    //下拉刷新
    func loadNew() {
        
        self.lastId = ""
        
        self.downloadListData()
    }
    
    
    //上拉加载更多
    func loadMore() {
        
        self.downloadListData()
    }
    
    
    //下载列表
    func downloadListData() -> Void {
        
        //拼接链接
        var urlString = String(format: kInfoListUrl, arguments: [self.newsType])
        //上拉加载更多
        if (self.lastId.isEmpty == false) {
            urlString = String(format: kInfoListMoreUrl, arguments: [self.lastId, self.newsType])
            print(urlString)
        }
        
        //如果是行情
        if self.newsType == "2" {
            urlString = String(format: "%@&cityCode=110000", arguments: [urlString])
        }
        
        
        //下载
        let downloader = MyDownloader()
        downloader.delegate = self
        downloader.downloadWithUrlString(urlString)
        
        
        
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

extension InformationViewController {
    
    func downloadFail(downloader: MyDownloader, error: NSError) {
        print(error)
    }
    
    func downloadFinish(downloader: MyDownloader) {
        
        //数据解析
        let result = try! NSJSONSerialization.JSONObjectWithData(downloader.receiveData!, options: NSJSONReadingOptions.MutableContainers)
        
        if result is Dictionary<String,AnyObject> {
            
            let dict = result as! Dictionary<String,AnyObject>
            
            let arr = dict["RESULT"] as! Array<AnyObject>
            
            for tmp in arr {
                let infoDict = tmp as! Dictionary<String,AnyObject>
                
                let model = InfoModel()
                model.setValuesForKeysWithDictionary(infoDict)
                
                self.dataArray.addObject(model)
                
            }
            
            
            //更新lastId的值
            if self.dataArray.count > 0 {
                let model = self.dataArray.lastObject as! InfoModel
                self.lastId = String(model.id)
            }
            
            //刷新表格
            self.performSelectorOnMainThread("refresh", withObject: nil, waitUntilDone: false)
            
        }
        
        
        
    }
    
    //刷新表格
    func refresh() {
    
        self.tbView?.reloadData()
        
        self.tbView?.headerView?.endRefreshing()
        self.tbView?.footerView?.endRefreshing()
        
    }
    
    
}


extension InformationViewController {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "kInfoCellId"
        
        var cell: InfoCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? InfoCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("InfoCell", owner: nil, options: nil).last as? InfoCell
        }
        
        
        let model = self.dataArray[indexPath.row] as! InfoModel
        cell?.config(model)
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}
