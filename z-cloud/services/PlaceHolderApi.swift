//
//  MarvelApi.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import Alamofire

class PlaceHolderApi {
    
    private let FIND_PHOTOS_URL = "https://jsonplaceholder.typicode.com/photos"
    
    func findPhotos(completion: @escaping ([PlaceHolderPhoto]) -> ()){
        
        AF.request(FIND_PHOTOS_URL)
            .validate()
            .responseDecodable(of: [PlaceHolderPhoto].self) { (response) in
                var photos : [PlaceHolderPhoto] = []
                if let responsePhotos = response.value {
                    photos.append(contentsOf: responsePhotos)
                }
                completion(photos)
        }
    }
}

struct PlaceHolderPhoto: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}
