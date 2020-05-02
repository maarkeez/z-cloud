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
    @IBOutlet weak var myIphoneBtn: UIBarButtonItem!
    @IBOutlet weak var myZCloudBtn: UIBarButtonItem!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myToolbar: UIToolbar!
    
    // MARK: - User actions
    @IBAction func onIphoneClick(_ sender: UIBarButtonItem) {
        loadPhotoGallery()
    }
    
    @IBAction func onCloudClick(_ sender: UIBarButtonItem) {
        loadZCloud()
    }
    
    // MARK: - Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myCollectionView.backgroundColor = UIConfiguration.singleton().color.mainBackground
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIConfiguration.singleton().color.navBarBackgroundColor
        setTitleColor(UIConfiguration.singleton().color.selectedBarButtonItem)
        self.navigationController?.navigationBar.isTranslucent = false
        self.myToolbar.isTranslucent = false
        self.myToolbar.barTintColor = UIConfiguration.singleton().color.navBarBackgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        PhotoAccessService.shared.checkPhotoLibraryAccess(self)
        loadPhotoGallery()
    }
    
    private func loadPhotoGallery(){
        self.title = "Photo Gallery"
        
        // Change button colors
        setTitleColor(UIConfiguration.singleton().color.selectedBarButtonItem)
        myIphoneBtn.tintColor = UIConfiguration.singleton().color.selectedBarButtonItem
        myZCloudBtn.tintColor = UIConfiguration.singleton().color.unSelectedBarButtonItem
        
        // Load data from source
        photoService = PhotoServiceFactory.singleton().get(.GALLERY)
        myCollectionView.reloadData()
        scrollToBottom()
    }
    
    private func loadZCloud(){
        self.title = "Z Cloud"
        
        // Change button colors
        setTitleColor(UIConfiguration.singleton().color.pinkBarButtonItem)
        myZCloudBtn.tintColor = UIConfiguration.singleton().color.pinkBarButtonItem
        myIphoneBtn.tintColor = UIConfiguration.singleton().color.unSelectedBarButtonItem
        
        // Load data from source
        photoService = PhotoServiceFactory.singleton().get(.ZCLOUD)
        myCollectionView.reloadData()
        scrollToBottom()
    }
    
    private func scrollToBottom(){
        let lastItemIndex = photoService.latestPhotoIndex()
        myCollectionView.scrollToItem(at: IndexPath(item: lastItemIndex, section: 0), at: .bottom, animated: false)
    }
    
    private func setTitleColor(_ color: UIColor){
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
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
        
        //Placeholder, mean real one loads
        cell.myImage.image=#imageLiteral(resourceName: "image-placeholder")
        
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
