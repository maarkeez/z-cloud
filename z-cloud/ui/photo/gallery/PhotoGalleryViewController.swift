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
    private var photoService = PhotoServiceFactory.singleton().get(.GALLERY)
    
    // MARK: - Visual elements
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBAction func onIphoneClick(_ sender: UIBarButtonItem) {
        loadPhotoGallery()
    }
    
    @IBAction func onCloudClick(_ sender: UIBarButtonItem) {
        loadZCloud()
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.backgroundColor = UIConfiguration.singleton().color.mainBackground
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        PhotoAccessService.shared.checkPhotoLibraryAccess(self)
        loadPhotoGallery()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lastItemIndex = photoService.latestPhotoIndex()
        myCollectionView.scrollToItem(at: IndexPath(item: lastItemIndex, section: 0), at: .bottom, animated: false)
    }
    
    private func loadPhotoGallery(){
        self.title = "Photo Gallery"
        photoService = PhotoServiceFactory.singleton().get(.GALLERY)
    }
    
    private func loadZCloud(){
        self.title = "Z Cloud"
        photoService = PhotoServiceFactory.singleton().get(.ZCLOUD)
    }
    
}

// MARK: - Extension to handle photo cells
extension PhotoGalleryViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoService.numberOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoGalleryCell
        cell.backgroundColor = .black
        cell.myImage.contentMode = .scaleAspectFill
        
        photoService.getPhoto(at: indexPath.row){(image) in
            cell.myImage.image=image
        }
        
        return cell
    }
        
    
}

// MARK: - Extension to handle cell events
extension PhotoGalleryViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        photoService.getPhoto(at: indexPath.row){(image) in
            if let image = image {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
                vc.myDisplayImage = image
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
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
