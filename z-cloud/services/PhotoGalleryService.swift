//
//  PhotoGalleryService.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoGalleryService: PhotoService {
        
    private let manager = PHImageManager.default()
    private var photoGalleryImages = [PHAsset]()
    
    init() {
        loadPhotoGalleryImages()
    }
    
    func numberOfPhotos() -> Int {
        return photoGalleryImages.count
    }
    
    func latestPhotoIndex() -> Int {
        return numberOfPhotos() - 1
    }
    
    func getPhoto(at photoIndex: Int,  completion: @escaping (_ photoImage: UIImage?)->()) {
        
        let asset = photoGalleryImages[photoIndex]

        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.resizeMode = .none
        
        // TODO: - Do not hard-code width and height to maximun expected
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 3840, height: 3840),
                             contentMode: .aspectFill,
                             options: requestOptions) { (result, _) in completion(result) }
        
    }
    
    private func loadPhotoGalleryImages() {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects({ (object, count, stop) in
           // self.cameraAssets.add(object)
            self.photoGalleryImages.append(object)
        })
    }
}
