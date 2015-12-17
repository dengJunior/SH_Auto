//
//  BaseViewController.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    
    //导航的方法
    
    //导航标题
    func addNavTitle(title: String) {
        
        
        let offsetX = CGFloat(80)
        let label = MyUtil.createLabel(CGRectMake(offsetX,0,kScreenW-offsetX*2,44), title: title, font: UIFont.boldSystemFontOfSize(28), textAlignment: NSTextAlignment.Center, textColor: UIColor(red: 50.0/225.0, green: 150.0/255.0, blue: 200.0/255.0, alpha: 1.0))
        
        self.navigationItem.titleView = label
    }
    
    
    //导航按钮
    func addNavBtn(bgImageName:String,isLeft:Bool,target:AnyObject?,action:Selector) {
        
        let w = CGFloat(48)
        let btn = MyUtil.createBtn(CGRectMake(0, 4, w, 36), bgImageName: bgImageName, selectBgImageName: nil, highlighBgImageName: nil, title: title, target: target, action: action)
        let barBtn = UIBarButtonItem(customView: btn)
        
        if isLeft {
            self.navigationItem.leftBarButtonItem = barBtn
        }else{
            self.navigationItem.rightBarButtonItem = barBtn
        }
        
        
    }
    
    
    //返回按钮
    func addNavBackBtn(target:AnyObject? ,action: Selector) {
        
        self.addNavBtn("back", isLeft: true, target: target, action: action)
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
