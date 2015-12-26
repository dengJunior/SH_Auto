//
//  MineViewController.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    //数据源
    var titleArray = Array<String>()
    var imageArray = Array<String>()
    
    //表格
    var tbView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addNavTitle("我的")
        
        self.titleArray = ["我的收藏","我的论坛","购车优惠","我的通知","摇号查询"]
        self.imageArray = ["myFavo","myForum","myOrder","myNews","drawlots"]
        
        //表格
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tbView = UITableView(frame: CGRectMake(0, 64+160, 375, 667-64), style: UITableViewStyle.Plain)
        self.tbView?.delegate = self
        self.tbView?.dataSource = self
        self.view.addSubview(self.tbView!)
        
        //图片
        let bgImageView = MyUtil.createImageView(CGRectMake(0, 64, 375, 160), imageName: "mySpaceBkgnd")
        self.view.addSubview(bgImageView)
        bgImageView.userInteractionEnabled = true
        
        //登陆按钮
        let loginBtn = MyUtil.createBtn(CGRectMake(170, 60, 40, 40), bgImageName: "loginPic", selectBgImageName: nil, highlighBgImageName: nil, title: nil, target: self, action: "loginAction")
        bgImageView.addSubview(loginBtn)
        
        //文字
        let label = MyUtil.createLabel(CGRectMake(155, 110, 70, 20), title: "登陆", font: UIFont.systemFontOfSize(18), textAlignment: NSTextAlignment.Center, textColor: UIColor.whiteColor())
        bgImageView.addSubview(label)
        
    }
    
    func loginAction() {
        print("登陆")
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

extension MineViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //重用Id
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if nil == cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = self.titleArray[indexPath.row]
        cell?.imageView?.image = UIImage(named: self.imageArray[indexPath.row])
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let collectCtrl = CollectViewController()
        self.navigationController?.pushViewController(collectCtrl, animated: true)
        
    }
}










