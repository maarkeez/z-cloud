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

protocol PhotoService {
    
    func reloadData(completion: @escaping (_ numberOfPhotos: Int)->())
    func getPhoto(at photoIndex: Int,  completion: @escaping (_ photoImage: UIImage?)->())
    func getPhotoUrl(at photoIndex: Int) -> String
    func getThumbnailUrl(at photoIndex: Int) -> String 
}
