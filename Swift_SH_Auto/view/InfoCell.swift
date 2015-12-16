//
//  InfoCell.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    
    @IBOutlet weak var infoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    //显示数据
    func config(model: InfoModel){
        
        //图片
        self.infoImageView.kf_setImageWithURL(NSURL(string: model.header_img_url!)!)
        //标题
        self.titleLabel.text = model.title
        self.titleLabel.numberOfLines = 2
        
        //时间
        let array = model.createTime?.componentsSeparatedByString(" ")
        self.timeLabel.text = array?.first
        
        //评论数
        self.commentLabel.text = "\(model.commentCount)"
        
        
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
