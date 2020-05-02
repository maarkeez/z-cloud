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
    
    private static let INSTANCE = ZCloudService()
    
    private let api = ZCloudApi()
    private var photos: [String] = []
    
    private init() {
        reloadData()
    }
    
    static func signleton() -> ZCloudService {
        return INSTANCE
    }
    
    func reloadData(){
        api.findPhotos { (photos) in
            self.photos = photos
        }
    }
    
    func numberOfPhotos() -> Int {
        return photos.count
    }
    
    func latestPhotoIndex() -> Int {
        return numberOfPhotos() > 0 ? numberOfPhotos() - 1 : 0
    }
    
    func getPhoto(at photoIndex: Int, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            let photoUrl = self.photos[photoIndex]
            let url = URL(string: photoUrl)
            if let url = url {
                let data = try? Data(contentsOf: url)
                if let data = data {
                    DispatchQueue.main.async {
                        completion(UIImage(data: data))
                    }
                }else{
                    print("Could not load (data): \(photoUrl)")
                    DispatchQueue.main.async {
                        completion(#imageLiteral(resourceName: "image-placeholder"))
                    }
                }
            }else{
                print("Could not load (url): \(photoUrl)")
                DispatchQueue.main.async {
                    completion(#imageLiteral(resourceName: "image-placeholder"))
                }
            }
        }
    }
    
    
}
