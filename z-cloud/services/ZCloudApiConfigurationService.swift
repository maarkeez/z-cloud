//
//  ZCloudApiConfigurationService.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation

class ZCloudApiConfigurationService {
    
    private static let INSTANCE = ZCloudApiConfigurationService()
    private var configuration : Configuration?
    
    static func singleton() -> ZCloudApiConfigurationService {
        return INSTANCE
    }
    
    func get() -> Configuration? {
        return configuration
    }
    
    func set(_ configuration: Configuration){
        self.configuration = configuration
        ZCloudService.signleton().reloadData()
    }
    
    class Configuration {
        var apiProtocol = "http"
        var apiHost = "127.0.0.1"
        var apiPort = "8080"
    }
}

