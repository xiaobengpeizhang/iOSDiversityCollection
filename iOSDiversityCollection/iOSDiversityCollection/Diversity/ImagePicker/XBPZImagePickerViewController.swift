//
//  XBPZImagePickerViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/7.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZImagePickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, TZImagePickerControllerDelegate {

    var collectionView: UICollectionView!
    var dataArray: [UIImage] = [UIImage]()
    
    
    override func loadView() {
        
        self.view = UIView()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 100, height: 100)
        
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib.init(nibName: "XBPZImagePIckerCell", bundle: Bundle.main), forCellWithReuseIdentifier: "XBPZImagePIckerCell")

        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView.backgroundColor = AARON_SWARTZ
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图片选择器"
        // Do any additional setup after loading the view.
    }

    
    // MARK:- CollectionDataSource&Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XBPZImagePIckerCell", for: indexPath) as! XBPZImagePIckerCell
        if indexPath.item == self.dataArray.count
        {
            cell.imageView.image = UIImage.init(named: "AlbumAddBtn")
        }
        else
        {
            cell.imageView.image = self.dataArray[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item == self.dataArray.count
        {
            let tz = TZImagePickerController.init(maxImagesCount: 9, columnNumber: 5, delegate: self, pushPhotoPickerVc: true)
            tz?.didFinishPickingPhotosHandle = { (images, asserts, isSelectOriginalPhoto) in
                self.dataArray = images!
                self.collectionView.reloadData()
            }
        
            self.present(tz!, animated: true, completion: nil)
        }
    }
}
