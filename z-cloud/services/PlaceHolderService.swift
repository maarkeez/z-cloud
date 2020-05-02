//
//  PlaceHolderService.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class PlaceHolderService: PhotoService {
    
    private let api = PlaceHolderApi()
    private var photos: [PlaceHolderPhoto] = []
  
    func reloadData(completion: @escaping (_ numberOfPhotos: Int)->()) {
        photos = []
        api.findPhotos { (photos) in
            self.photos = photos
        }
        completion(photos.count)
    }
    
    func getPhoto(at photoIndex: Int, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            let photoUrl = self.photos[photoIndex].url
            let url = URL(string: photoUrl)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                completion(UIImage(data: data!))
            }
        }
    }
    
    
}
