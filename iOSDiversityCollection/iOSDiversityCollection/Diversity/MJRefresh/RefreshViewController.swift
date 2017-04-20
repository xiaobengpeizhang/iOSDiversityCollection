//
//  RefreshViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/4/5.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "上拉加载"
        self.layout()
    }
    
    func layout()
    {
        self.tableView = UITableView.init(frame: self.view.bounds)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(refresh))
        footer?.setTitle("上拉加载", for: .idle)
        footer?.setTitle("加载更多", for: .refreshing)
        footer?.setTitle("没有更多数据", for: .noMoreData)
        self.tableView.backgroundColor = UIColor.yellow
        self.tableView.mj_footer = footer
    }
    
    func refresh()
    {
        print("5")
        self.tableView.mj_footer.endRefreshing()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
        }
        cell!.textLabel?.text = "cell"
        cell!.backgroundColor = UIColor.red
        return cell!
    }
}
