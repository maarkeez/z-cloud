//
//  PhotoService.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class PhotoService {
    
    private static let INSTANCE = PhotoService()
    private let photoImages : [UIImage] = [ #imageLiteral(resourceName: "sample-image-3"), #imageLiteral(resourceName: "blue-cloud"), #imageLiteral(resourceName: "sample-image-2") ]
    
    static func singleton() -> PhotoService{
        return .INSTANCE
    }
    
    func numberOfPhotos() -> Int {
        return photoImages.count
    }
    
    func latestPhotoIndex() -> Int {
        return numberOfPhotos() - 1
    }
    
    func getPhoto(withIndex photoIndex: Int) -> UIImage {
        return photoImages[photoIndex]
    }
    
}
