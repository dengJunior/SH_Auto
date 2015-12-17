//
//  InfoHeadView.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit


protocol InfoHeaderViewDelegte: NSObjectProtocol {
    
    
    func didSelectType(type: String,titleStr: String)
}

class InfoHeadView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    //背景视图
    var bgView: UIView?
    
    //按钮列表
    var listBgView: UIView?
    
    //标题的滚动视图
    var scrollView: UIScrollView?
    
    //标题对应的类型值
    var titleArray: Array<String>?
    
    //选中的序号
    var sIndex: NSInteger = 0
    
    //标题对应的字典
    var titleDict: Dictionary<String,String>?
    
    //代理
    var delegate: InfoHeaderViewDelegte?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        //滚动视图
        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, 375-60, 30))
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.addSubview(self.scrollView!)
        
        //按钮
        let btn = MyUtil.createBtn(CGRectMake(375-50, 0, 30, 30), bgImageName: "showItemView", selectBgImageName: nil, highlighBgImageName: nil, title: nil, target: self, action: "clickBtn")
        self.addSubview(btn)
        
        
        self.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //点击按钮
    func clickBtn(){
        //背景视图
        self.bgView = UIView(frame: CGRectMake(0, 64, 375, 667-64))
        self.bgView?.backgroundColor = UIColor.grayColor()
        self.bgView?.alpha = 0.4
        
        self.superview?.addSubview(self.bgView!)
        
        
        //添加按钮列表
        self.listBgView = UIView(frame: CGRectMake(0, 64, 375, 150))
        self.listBgView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.superview?.addSubview(self.listBgView!)
        
        
        //添加标题
        let titleLabel = MyUtil.createLabel(CGRectMake(20, 8, 72, 20), title: "切换栏目", font: UIFont.systemFontOfSize(16), textAlignment: NSTextAlignment.Left, textColor: UIColor.blackColor())
        self.listBgView?.addSubview(titleLabel)
        
        let lineView = UIView(frame: CGRectMake(0, 30, 375, 1))
        lineView.backgroundColor = UIColor.lightGrayColor()
        self.listBgView?.addSubview(lineView)
        
        let redView = UIView(frame: CGRectMake(20, 30, 72, 1))
        redView.backgroundColor = UIColor.redColor()
        self.listBgView?.addSubview(redView)
        
        //关闭按钮
        let closeBtn = MyUtil.createBtn(CGRectMake(375-50, 0, 30, 30), bgImageName: "closeItemView", selectBgImageName: nil, highlighBgImageName: nil, title: nil, target: self, action: "closeAction")
        self.listBgView?.addSubview(closeBtn)
        
        
        //按钮
        let h = 30
        let spaceY = 20
        let offsetY = 50
        let w = 60
        let spaceX = 20
        let offsetX = 20
        
        for var i=0;i<self.titleArray?.count;i++ {
            
            let row = i/4
            let col = i%4
            
            //循环创建按钮
            let frame = CGRectMake(CGFloat(offsetX+(w+spaceX)*col), CGFloat(offsetY+(h+spaceY)*row), CGFloat(w), CGFloat(h))
            let btn = MyUtil.createBtn(frame, bgImageName: "zhankai_bg", selectBgImageName: nil, highlighBgImageName: nil, title: self.titleArray![i], target: self, action: "selectAction:")
            
            btn.tag = 200+i
            
            if i == self.sIndex {
                btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            }else{
                btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
            
            
            self.listBgView?.addSubview(btn)
            
        }
        
        
        
    }
    
    
    func selectAction(btn: UIButton) {
        let index = btn.tag-200
        
        self.selectBtnAtIndex(index)
        
        self.hideBgView()
    }
    
    func selectBtnAtIndex(index: NSInteger) {
        
        //标题和类型
        let title = self.titleArray![index]
        let type = self.titleDict![title]
        
        
        //修改UI
        let lastSelectBtn = self.viewWithTag(1000+self.sIndex) as! UIButton
        lastSelectBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        let curSelectBtn = self.viewWithTag(1000+index) as! UIButton
        curSelectBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        //设置选中序号
        self.sIndex = index
        
        //重新显示数据
        self.delegate?.didSelectType(type!, titleStr: title)
        
        //修改滚动视图的偏移量
        let x = CGFloat(self.sIndex*(60+20))
        
        let flag = CGFloat(x+(self.scrollView?.bounds.size.width)!) >= self.scrollView!.contentSize.width
        if flag {
            self.scrollView!.contentOffset = CGPointMake(self.scrollView!.contentSize.width-self.scrollView!.bounds.size.width, 0);
        }else{
            self.scrollView!.contentOffset = CGPointMake(x, 0);
        }
        
    }
    
    
    func hideBgView() {
        
        self.bgView?.removeFromSuperview()
        self.bgView = nil
        
        self.listBgView?.removeFromSuperview()
        self.listBgView = nil
        
    }
    
    
    
    //显示滚动的标题
    func configTitle() {
        let w = 60
        let h = 30
        let spaceX = 20
        let offsetX = 20
        
        for var i=0;i<self.titleArray?.count;i++ {
            //标题
            let title = self.titleArray![i]
            
            let frame = CGRectMake(CGFloat(offsetX+(w+spaceX)*i), 0, CGFloat(w), CGFloat(h));
            let btn = MyUtil.createBtn(frame, bgImageName: nil, selectBgImageName: nil, highlighBgImageName: nil, title: title, target: self, action: "selectTitle:")
            if i == self.sIndex {
                btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            }else{
                btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
            btn.tag = 1000+i
            self.scrollView?.addSubview(btn)
            
        }
        
        
        self.scrollView?.contentSize = CGSizeMake(CGFloat((w+spaceX)*self.titleArray!.count), 30)
        
    }
    
    
    //点击标题的按钮
    func selectTitle(btn: UIButton) {
        let index = btn.tag-1000
        self.selectBtnAtIndex(index)
    }
    
    deinit {
        self.hideBgView()
    }
    
    

}
