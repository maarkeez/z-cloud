//
//  ZCloudService.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class ZCloudService : PhotoService {
    
    func numberOfPhotos() -> Int {
        return 0
    }
    
    func latestPhotoIndex() -> Int {
        return 0
    }
    
    func getPhoto(at photoIndex: Int, completion: @escaping (UIImage?) -> ()) {
        completion(nil)
    }
    
    
}
