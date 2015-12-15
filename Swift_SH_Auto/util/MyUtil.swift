//
//  MyUtil.swift
//  TestLimit
//
//  Created by gaokunpeng on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class MyUtil: NSObject {
    
    //创建控件的方法
    class func createLabel(frame:CGRect,title:String?,font:UIFont,textAlignment:NSTextAlignment,textColor:UIColor) -> UILabel {
        
        let label = UILabel(frame: frame)
        if nil != title {
            label.text = title
        }
        label.textAlignment = textAlignment
        label.font = font
        label.textColor = textColor
        return label
    }
    
    
    class func createBtn(frame:CGRect,bgImageName:String?,selectBgImageName:String?,highlighBgImageName:String?,title:String?,target:AnyObject?,action:Selector) -> UIButton {
        
        let btn = UIButton(type: UIButtonType.Custom)
        btn.frame = frame
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        if nil != bgImageName {
            btn.setBackgroundImage(UIImage(named: bgImageName!), forState: UIControlState.Normal)
        }
        if nil != selectBgImageName {
            btn.setBackgroundImage(UIImage(named: selectBgImageName!), forState: UIControlState.Selected)
        }
        if nil != highlighBgImageName {
            btn.setBackgroundImage(UIImage(named: highlighBgImageName!), forState: UIControlState.Highlighted)
        }
        
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }
    
    class func createImageView(frame:CGRect,imageName:String?) -> UIImageView {
        
        let imgView = UIImageView(frame: frame)
        if nil != imageName {
            imgView.image = UIImage(named: imageName!)
        }
        return imgView
        
    }
    
    
    class func createTextField(frame:CGRect,placeHolder:String,isSecury:Bool) -> UITextField {
    
        let textField = UITextField(frame: frame)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.secureTextEntry = isSecury
        textField.placeholder = placeHolder
        return textField
    }
    
    
    
    //类型转换成文字
    class func transferCateName(name: String) -> String? {
        if name == "Business" {
            return "商业"
        }else if name == "Weather" {
            return "天气"
        }else if name == "Tool" {
            return "工具"
        }else if name == "Travel" {
            return "旅行"
        }else if name == "Sports" {
            return "体育"
        }else if name == "Social" {
            return "社交"
        }else if name == "Refer" {
            return "参考"
        }else if name == "Ability" {
            return "效率"
        }else if name == "Photography" {
            return "摄影"
        }else if name == "News" {
            return "新闻"
        }else if name == "Gps" {
            return "导航"
        }else if name == "Music" {
            return "音乐"
        }else if name == "Life" {
            return "生活"
        }else if name == "Health" {
            return "健康"
        }else if name == "Finance" {
            return "财务"
        }else if name == "Pastime" {
            return "娱乐"
        }else if name == "Education" {
            return "教育"
        }else if name == "Book" {
            return "书籍"
        }else if name == "Medical" {
            return "医疗"
        }else if name == "Catalogs" {
            return "商品指南"
        }else if name == "FoodDrink" {
            return "美食"
        }else if name == "Game" {
            return "游戏"
        }else if name == "All" {
            return "全部"
        }
        
        return nil
    }

    

}
