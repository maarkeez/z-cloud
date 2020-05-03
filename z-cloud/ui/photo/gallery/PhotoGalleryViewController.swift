//
//  PhotoGalleryViewController.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class PhotoGalleryViewController: UIViewController {
    
    // MARK: - Properties
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 2.5, left: 10.0, bottom: 2.5, right: 10.0)
    private var photoServiceType = PhotoServiceFactory.SourceType.GALLERY
    private var photoService = PhotoServiceFactory.singleton().get(.GALLERY)
    private var itemCount = 0
    private var photoCellProvider : PhotoCellProvider = PhotoCellProviderGallery()
    
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
    
    @IBAction func onSettingsClick(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        // FIXME: - This extra scroll should not be needed, why its happening?
        scrollToBottom()
        self.myCollectionView.performBatchUpdates(nil) { (animationsCompleted) in
            if animationsCompleted {
                self.loadAllVisibleCells()
            }
        }
    }
    
    private func loadPhotoGallery(){
        self.title = "Photo Gallery"
        
        // Change button colors
        setTitleColor(UIConfiguration.singleton().color.selectedBarButtonItem)
        myIphoneBtn.tintColor = UIConfiguration.singleton().color.selectedBarButtonItem
        myZCloudBtn.tintColor = UIConfiguration.singleton().color.unSelectedBarButtonItem
        
        // Load data from source
        photoCellProvider = PhotoCellProviderGallery()
        self.itemCount = 0
        self.myCollectionView.reloadData()
        photoServiceType = PhotoServiceFactory.SourceType.GALLERY
        photoService = PhotoServiceFactory.singleton().get(.GALLERY)
        photoService.reloadData(){(numberOfPhotos) in
            self.itemCount = numberOfPhotos
            self.myCollectionView.reloadData()
            self.scrollToBottom()
            self.myCollectionView.performBatchUpdates(nil) { (animationsCompleted) in
                if animationsCompleted {
                    self.loadAllVisibleCells()
                }
            }
        }
    }
    
    private func loadZCloud() {
        self.title = "Z Cloud"
        
        // Change button colors
        setTitleColor(UIConfiguration.singleton().color.pinkBarButtonItem)
        myZCloudBtn.tintColor = UIConfiguration.singleton().color.pinkBarButtonItem
        myIphoneBtn.tintColor = UIConfiguration.singleton().color.unSelectedBarButtonItem
        
        // Load data from source
        photoCellProvider = PhotoCellProviderZCloud()
        self.itemCount = 0
        self.myCollectionView.reloadData()
        photoServiceType = PhotoServiceFactory.SourceType.ZCLOUD
        photoService = PhotoServiceFactory.singleton().get(.ZCLOUD)
        photoService.reloadData(){(numberOfPhotos) in
            self.itemCount = numberOfPhotos
            self.myCollectionView.reloadData()
            self.scrollToBottom()
            self.myCollectionView.performBatchUpdates(nil) { (animationsCompleted) in
                if animationsCompleted {
                    self.loadAllVisibleCells()
                }
            }
            
        }
    }
    
    private func scrollToBottom(){
        if (itemCount > 0){
            myCollectionView.scrollToItem(at: IndexPath(item: itemCount - 1, section: 0), at: .bottom, animated: false)
        }
    }
    
    private func setTitleColor(_ color: UIColor){
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
        self.navigationController?.navigationBar.tintColor = color
    }
    
    private func loadAllVisibleCells(){
        for cell in myCollectionView.visibleCells  as! [PhotoGalleryCell]    {
            if let indexPath = myCollectionView.indexPath(for: cell as PhotoGalleryCell){
                photoCellProvider.loadCellImage(cell, indexPath: indexPath, photoService: photoService)
            }
        }
    }
    
    
}

// MARK: - Extension to handle photo cells
extension PhotoGalleryViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return photoCellProvider.collectionView(collectionView, cellForItemAt: indexPath, photoService: photoService)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadAllVisibleCells()
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
