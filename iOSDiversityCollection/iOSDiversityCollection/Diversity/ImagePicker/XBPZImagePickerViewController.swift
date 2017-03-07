//
//  XBPZImagePickerViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/7.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZImagePickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, TZImagePickerControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray: [UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图片选择器"
        self.setupCollectionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
    func setupCollectionView()
    {
        self.collectionView.register(UINib.init(nibName: "XBPZImagePIckerCell", bundle: Bundle.main), forCellWithReuseIdentifier: "XBPZImagePIckerCell")
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 100, height: 100)
        self.collectionView.collectionViewLayout = layout
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
