//
//  DetailViewController.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, MyDownloaderDelegate {
    
    
    
    //传过来的模型对象
    var model: InfoModel?
    
    //下载回来的数据
    var detailModel: DetailModel?
    
    //webView
    var webView: UIWebView?
    
    //收藏按钮
    var collectBtn: UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //标题
        self.navigationItem.title = "详情"
        
        //返回按钮
        self.addNavBackBtn(self, action: "backAction")
        
        //用UIWebView显示数据
        self.webView = UIWebView(frame: CGRectMake(0,0,375,667))
        self.webView?.backgroundColor = UIColor.grayColor()
        self.view.addSubview(self.webView!)
       
        if self.model != nil{
            
            let urlString = String(format: kDetailUrl, arguments: [(self.model?.id)!])
            
            
            //下载数据
            let downloader = MyDownloader()
            downloader.delegate = self
            downloader.downloadWithUrlString(urlString)
            
        }
        
        
        //显示加载精度条
        MyUtil.showActivityOnView(self.view)
        
        
    }
    
    
    //返回按钮
    func backAction() -> Void {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //刷新
    func refreshWebView() {
        
        let url = NSURL(string: (self.detailModel?.url)!)
        
        let request = NSURLRequest(URL: url!)
        
        self.webView?.loadRequest(request)
        
        //显示收藏按钮
        self.collectBtn = self.addNavBtn("new_collectBtn_normal", isLeft: false, target: self, action: "collectAction")
        
        //看看是否已经收藏
        let flag = DBManager.sharedManager().isInfoCollect(self.model!.id)
        if flag == false {
 
            self.collectBtn?.setBackgroundImage(UIImage(named: "new_collectBtn_normal"), forState: UIControlState.Normal)
        }else{

            self.collectBtn?.setBackgroundImage(UIImage(named: "new_collect_selected"), forState: UIControlState.Normal)
        }

        
        //隐藏加载精度条
        MyUtil.hideActivityOnView(self.view)
        
    }
    
    //收藏
    func collectAction() {
        
        //看看是否已经收藏
        let flag = DBManager.sharedManager().isInfoCollect(self.model!.id)
        
        if flag {
            //取消收藏
            DBManager.sharedManager().deleteModel((self.model?.id)!)
            
            self.collectBtn?.setBackgroundImage(UIImage(named: "new_collectBtn_normal"), forState: UIControlState.Normal)
        }else{
            //收藏
            var dict = Dictionary<String,AnyObject?>()
            dict[kInfoId] = self.model?.id
            dict[kHeadImageUrl] = self.model?.header_img_url
            dict[kTitle] = self.detailModel?.title
            dict[kDate] = self.model?.createTime
            dict[kCommentCount] = self.model?.commentCount
            
            DBManager.sharedManager().addCollect(dict)
            
            self.collectBtn?.setBackgroundImage(UIImage(named: "new_collect_selected"), forState: UIControlState.Normal)
        }
        
        
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


extension DetailViewController {

    func downloadFail(downloader: MyDownloader, error: NSError) {
        print(error)
    }
    
    
    func downloadFinish(downloader: MyDownloader) {
        
        //JSON解析
        let result = try! NSJSONSerialization.JSONObjectWithData(downloader.receiveData!, options: NSJSONReadingOptions.MutableContainers)
        
        //获取数组
        if result is NSDictionary {
            
            let dict = result as! NSDictionary
            
            let arr = dict.objectForKey("RESULT")!.objectForKey("sub_pages") as! NSArray
            
            if arr.count > 0 {
                
                //解析数据
                let subDict = arr.lastObject as! Dictionary<String,AnyObject>
                
                self.detailModel = DetailModel()
                self.detailModel?.setValuesForKeysWithDictionary(subDict)
                
                self.performSelectorOnMainThread("refreshWebView", withObject: nil, waitUntilDone: false)
                
            }
            
            
            
            
            
        }
        
        
    }
    
}


