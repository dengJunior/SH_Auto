//
//  CollectCell.swift
//  Swift_SH_Auto
//
//  Created by gaokunpeng on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CollectCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    func configModel(model: CollectModel) {
        
        self.leftImageView.kf_setImageWithURL(NSURL(string: model.headImageUrl!)!)
        
        self.titleLabel.text = model.title
        self.titleLabel.numberOfLines = 2
        
        self.dateLabel.text = model.date
        
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
