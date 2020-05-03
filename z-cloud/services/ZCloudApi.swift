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
    
    func findPhotos(completion: @escaping ([PhotoItem]) -> ()){
        
        let baseUrlOpt = getBaseUrl()
        guard let baseUrl = baseUrlOpt else {
            completion([])
            return
        }
        
        let url = "\(baseUrl)/api/photos"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [PhotoItem].self) { (response) in
                
                if let responsePhotos = response.value {
                    completion(responsePhotos)
                }
        }
    }
    
    private func getBaseUrl() -> String? {
        
        if  let configuration = ZCloudApiConfigurationService.singleton().get() {
            
            var baseUrl = "\(configuration.apiProtocol)://\(configuration.apiHost)"
            
            if(configuration.apiPort != ""){
                baseUrl += ":\(configuration.apiPort)"
            }
            
            return baseUrl
        }
        
        return nil
        
    }
    
    func getPhotoNameUrl(_ photoItem: PhotoItem) -> String? {
        guard let baseUrl = getBaseUrl() else {
            return nil
        }
        
        return "\(baseUrl)/api/photos/name/\(photoItem.path)"
    }
    
    func getThumbnailNameUrl(_ photoItem: PhotoItem) -> String? {
        guard let baseUrl = getBaseUrl() else {
            return nil
        }
        
        return "\(baseUrl)/api/thumbnail/name/\(photoItem.path)"
    }
}


struct PhotoItem: Decodable {
    let path: String
    let creationDate: CLong
    
    enum CodingKeys: String, CodingKey {
        case path
        case creationDate
    }
}
