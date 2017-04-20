//
//  XBPZOneCellTableViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/4/20.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZOneCellTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.tableView.sectionHeaderHeight = 0.0
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.register(UINib.init(nibName: "XBPZOneCell", bundle: Bundle.main), forCellReuseIdentifier: "XBPZOneCell")
        self.tableView.backgroundColor = AARON_SWARTZ
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "XBPZOneCell") as! XBPZOneCell
        cell.config(iconString: "\u{e61f}", label1: "上面的labl", label2: "下面的label", buttonString: "去收藏", buttonColor: UIColor.white, iconColor: UIColor.red)
        cell.backgroundColor = AARON_SWARTZ
        cell.selectionStyle = .none
        cell.button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return cell
    }
    
    func test()
    {
        print("1")
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.view.bounds.height
    }

}
