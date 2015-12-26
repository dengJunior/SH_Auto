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
    
    
    //显示加载进度条
    class func showActivityOnView(superView: UIView){
        
            let activityView = UIActivityIndicatorView(frame: CGRectMake(120, 200, kScreenW-120*2, 100))
            activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
            activityView.backgroundColor = UIColor.grayColor()
            activityView.startAnimating()
            activityView.tag = 314
            activityView.layer.cornerRadius = 10
            superView.addSubview(activityView)
    }
    
    //隐藏加载进度条
    class func hideActivityOnView(superView: UIView)-> Void {
        let activityView = superView.viewWithTag(314) as! UIActivityIndicatorView
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }

    

}
