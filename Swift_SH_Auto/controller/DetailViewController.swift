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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
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
        self.showActivity()
        
        
    }
    
    
    func showActivity() {
    
        
        
        let activityView = UIActivityIndicatorView(frame: CGRectMake(160, 200, (kScreenW-80*2)/2, 100))
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityView.backgroundColor = UIColor.grayColor()
        activityView.startAnimating()
        activityView.tag = 314
        self.view.addSubview(activityView)
        
        
    }
    
    func hideActivity () {
        
        let activityView = self.view.viewWithTag(314) as! UIActivityIndicatorView
        activityView.stopAnimating()
        
        
    }
    
    
    //刷新
    func refreshWebView() {
        
        let url = NSURL(string: (self.detailModel?.url)!)
        
        let request = NSURLRequest(URL: url!)
        
        self.webView?.loadRequest(request)
        
        //隐藏加载精度条
        self.hideActivity()
        
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


