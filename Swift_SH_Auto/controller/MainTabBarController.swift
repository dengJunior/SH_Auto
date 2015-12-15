//
//  MainTabBarController.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.createViewControllers()
        
    }
    
    
    
    //创建视图控制器
    func createViewControllers() {
        
        //文字
        let titles = ["资讯","找车","特惠","论坛","我的"]
        //图片
        let images = ["tab_news_normal","tab_selectCar_normal","tab_preferentialCar_normal","tab_forum_normal","tab_forum_normal"]
        //选中下的图片
        let selectImages = ["tab_news_highlighted","tab_selectCar_highlighted","tab_preferentialCar_highlighted","tab_forum_highlighted","tab_forum_highlighted"]
        let ctrlArray: Array<UIViewController>= [InformationViewController(),SearchViewController(),IndulgenceViewController(),ForumViewController(),MineViewController()]
        
        
        var array: Array<UIViewController> = Array()
        //设置视图控制器的tabBarItem
        for var i=0;i<titles.count;i++ {
        
            let ctrl = ctrlArray[i]
            ctrl.tabBarItem.title = titles[i]
            ctrl.tabBarItem.image = UIImage(named: images[i])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            ctrl.tabBarItem.selectedImage = UIImage(named: selectImages[i])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
            //创建导航
            let navCtrl = UINavigationController(rootViewController: ctrl)
            
            array.append(navCtrl)
        }
        
        self.viewControllers = array
        
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
