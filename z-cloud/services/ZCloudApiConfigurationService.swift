//
//  ZCloudApiConfigurationService.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation

class ZCloudApiConfigurationService {
    
    private static let KEY_HOST = "zcloud_host"
    private static let KYE_PORT = "zcloud_port"
    private static let INSTANCE = ZCloudApiConfigurationService()
    
    private var configuration : Configuration?
    
    private init(){
        let defaults = UserDefaults.standard
        if let host = defaults.object(forKey: ZCloudApiConfigurationService.KEY_HOST) as? String {
            configuration = Configuration()
            configuration?.apiHost = host
            configuration?.apiPort = defaults.object(forKey: ZCloudApiConfigurationService.KYE_PORT) as! String
        }
    }
    
    static func singleton() -> ZCloudApiConfigurationService {
        return INSTANCE
    }
    
    func get() -> Configuration? {
        return configuration
    }
    
    func set(_ configuration: Configuration){
        self.configuration = configuration
        let defaults = UserDefaults.standard
        defaults.set(configuration.apiHost, forKey: ZCloudApiConfigurationService.KEY_HOST)
        defaults.set(configuration.apiPort, forKey: ZCloudApiConfigurationService.KYE_PORT)
        ZCloudService.signleton().reloadData()
    }
    
    class Configuration {
        var apiProtocol = "http"
        var apiHost = "127.0.0.1"
        var apiPort = "8080"
    }
}

