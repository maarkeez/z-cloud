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
            
    func findPhotos(completion: @escaping ([String]) -> ()){
        
        let configurationOpt = ZCloudApiConfigurationService.singleton().get()
        guard let configuration = configurationOpt else {
            completion([])
            return
        }
        
        var port = ""
        if(configuration.apiPort != ""){
            port = ":\(configuration.apiPort)"
        }
        
        let FIND_PHOTOS_URL = "\(configuration.apiProtocol)://\(configuration.apiHost)\(port)/api/photos"
        AF.request(FIND_PHOTOS_URL)
            .validate()
            .responseDecodable(of: [String].self) { (response) in
                var photos : [String] = []
                if let responsePhotos = response.value {
                    for photo in responsePhotos{
                        photos.append("\(FIND_PHOTOS_URL)/name/\(photo)")
                    }
                }
                completion(photos)
        }
    }
}
