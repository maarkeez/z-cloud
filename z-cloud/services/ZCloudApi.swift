//
//  ZCloudApi.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import Alamofire

class ZCloudApi {
    private let FIND_PHOTOS_URL = "http://192.168.1.34:8080/api/photos"
    
    func findPhotos(completion: @escaping ([String]) -> ()){
        
        AF.request(FIND_PHOTOS_URL)
            .validate()
            .responseDecodable(of: [String].self) { (response) in
                var photos : [String] = []
                if let responsePhotos = response.value {
                    for photo in responsePhotos{
                        photos.append("\(self.FIND_PHOTOS_URL)/name/\(photo)")
                    }
                }
                completion(photos)
        }
    }
}
