//
//  XBPZBootstrapButtonViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/16.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZBootstrapButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
        self.view.addSubview(button)
        button.backgroundColor = UIColor.white
        button.setTitle("哥伦比亚 Supremo 慧兰", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.defaultStyle()
        button.addAwesomeIcon(FAIconUnlock, beforeTitle: false)
        button.addTarget(self, action: #selector(changeLock), for: .touchUpInside)
        button.setup()
        // Do any additional setup after loading the view.
    }
    
    func changeLock(button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.removeAwesomeIcon(FAIconUnlock, beforeTitle: false)
            button.addAwesomeIcon(FAIconLock, beforeTitle: false)
        }
        else {
            button.removeAwesomeIcon(FAIconLock, beforeTitle: false)
            button.addAwesomeIcon(FAIconUnlock, beforeTitle: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
