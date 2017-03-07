//
//  XBPZRootViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/7.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZRootViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray: [String] = [String]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "目录"
        // Do any additional setup after loading the view.
        self.setupDataArray()
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupDataArray()
    {
        self.dataArray = ["图片选择器"]
    }

    func setupCollectionView()
    {
        self.collectionView.register(UINib.init(nibName: "XBPZRootCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "XBPZRootCollectionCell")
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 100, height: 150)
        self.collectionView.collectionViewLayout = layout
    }
    
    // MARK:- CollectionDataSource&Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XBPZRootCollectionCell", for: indexPath) as! XBPZRootCollectionCell
        cell.titleLabel.text = self.dataArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let imagePicker = XBPZImagePickerViewController()
        self.navigationController?.pushViewController(imagePicker, animated: true)
    }
}
