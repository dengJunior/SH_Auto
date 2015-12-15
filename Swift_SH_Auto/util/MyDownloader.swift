//
//  MyDownloader.swift
//  TestLimit
//
//  Created by gaokunpeng on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit


protocol MyDownloaderDelegate : NSObjectProtocol {
    
    //下载成功
    func downloadFinish(downloader: MyDownloader)
    
    //下载失败
    func downloadFail(downloader:MyDownloader, error:NSError)
}


class MyDownloader: NSObject {
    
    //下载对象
    var task: NSURLSessionTask?
    
    //下载回来的数据
    var receiveData:NSData?
    
    //代理
    var delegate: MyDownloaderDelegate?
    
    //类型
    var type: NSInteger?
    
    
    //下载方法
    func downloadWithUrlString(urlString: String) {
    
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            
            self.receiveData = data
            
            //下载失败
            if nil != error {
                self.delegate?.downloadFail(self, error: error!)
            }else{
                
                let res = response as! NSHTTPURLResponse
                if res.statusCode == 200 {
                    //下载成功
                    self.delegate?.downloadFinish(self)
                }else{
                    
                    let err = NSError(domain: "下载失败", code: res.statusCode, userInfo: nil)
                    
                    self.delegate?.downloadFail(self, error: err)
                }
                
            }
            
        })
        task?.resume()
        
    }
    
    
    

}
