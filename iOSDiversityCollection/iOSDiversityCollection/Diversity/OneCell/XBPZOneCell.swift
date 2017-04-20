//
//  XBPZOneCell.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/4/20.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZOneCell: UITableViewCell {
    
    @IBOutlet weak var icon: UILabel!
    
    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(iconString: String, label1: String, label2: String, buttonString: String, buttonColor: UIColor, iconColor: UIColor)
    {
        self.icon.text = iconString
        self.label1.text = label1
        self.label2.text = label2
        self.button.setTitle(buttonString, for: .normal)
        self.button.setTitleColor(buttonColor, for: .normal)
        self.icon.textColor = iconColor
        self.button.dangerStyle()
    }
    
}
