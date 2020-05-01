//
//  PhotoGalleryViewController.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    
    // MARK: - Properties
    private let reuseIdentifier = "PhotoGalleryCell"
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 2.5, left: 10.0, bottom: 2.5, right: 10.0)
    
    // MARK: - Visual elements
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.backgroundColor = UIConfiguration.singleton().color.mainBackground
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        PhotoAccessService.shared.checkPhotoLibraryAccess(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lastItemIndex = PhotoService.singleton().latestPhotoIndex()
        myCollectionView.scrollToItem(at: IndexPath(item: lastItemIndex, section: 0), at: .bottom, animated: false)
    }
    
    func getPhoto(at indexPath: IndexPath) -> UIImage {
        return PhotoService.singleton().getPhoto(withIndex: indexPath.row)
    }
}

// MARK: - Extension to handle photo cells
extension PhotoGalleryViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoService.singleton().numberOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoGalleryCell
        cell.backgroundColor = .black
        cell.myImage.contentMode = .scaleAspectFill
        cell.myImage.image = getPhoto(at: indexPath)
        return cell
    }
        
    
}

// MARK: - Extension to handle cell events
extension PhotoGalleryViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        vc.myDisplayImage = getPhoto(at: indexPath)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension to handle layout
extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}
