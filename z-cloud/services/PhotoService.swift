//
//  PhotoService.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoService {
    
    private static let INSTANCE = PhotoService()
    private let photoImages : [UIImage] = [ #imageLiteral(resourceName: "sample-image-3"), #imageLiteral(resourceName: "blue-cloud"), #imageLiteral(resourceName: "sample-image-2") ]
    
    private let manager = PHImageManager.default()
    private var photoGalleryImages = [PHAsset]()
    
    init() {
        loadPhotoGalleryImages()
    }
    
    static func singleton() -> PhotoService{
        return .INSTANCE
    }
    
    func numberOfPhotos() -> Int {
        return photoGalleryImages.count
    }
    
    func latestPhotoIndex() -> Int {
        return numberOfPhotos() - 1
    }
    
    func getPhoto(at photoIndex: Int,  completion: @escaping (_ photoImage: UIImage?)->()) {
        
        let asset = photoGalleryImages[photoIndex]
        
        // TODO: - Do not hard-code width and height
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.resizeMode = .none
        
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 3840, height: 3840),
                             contentMode: .aspectFill,
                             options: requestOptions) { (result, _) in
                                completion(result)
                            }
        
    }
    
    private func loadPhotoGalleryImages() {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects({ (object, count, stop) in
           // self.cameraAssets.add(object)
            self.photoGalleryImages.append(object)
        })
    }
}
