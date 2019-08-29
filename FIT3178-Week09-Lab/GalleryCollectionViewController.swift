//
//  GalleryCollectionViewController.swift
//  FIT3178-Week09-Lab
//
//  Created by hideto on 26/8/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "imageCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
    var imageList = [UIImage]()
    var imagePathList = [String]()
    var managedObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate?.persistantContainer?.viewContext
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        
        do {
            let imageDataList = try
                managedObjectContext!.fetch(ImageMetaData.fetchRequest())
                as [ImageMetaData]
            
            
            if(imageDataList.count > 0) {
                for data in imageDataList {
                    let fileName = data.filename!
                    if(imagePathList.contains(fileName)) {
                        print("Image already loaded in. Skipping image")
                        continue
                    }
                    if let image = loadImageData(fileName: fileName) {
                        self.imageList.append(image)
                        self.imagePathList.append(fileName)
                        self.collectionView!.reloadSections([0])
                    }
                }
            }
        }catch{
            print("Unable to fetch list of parties")
        }
                
                    
    }
    
    func loadImageData(fileName: String) -> UIImage? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        var image: UIImage?
        if let pathComponent = url.appendingPathComponent(fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            let fileData = fileManager.contents(atPath: filePath)
            image = UIImage(data: fileData!)
        }
        return image
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell

        cell.backgroundColor = UIColor.lightGray
        cell.imageView.image = imageList[indexPath.row]
        
    
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, insetForSectionAt
        section: Int) -> UIEdgeInsets {
        return sectionInsets
    }


    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt
        section: Int) -> CGFloat {
        return sectionInsets.left
    }



}
