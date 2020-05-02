//
//  PhotoServiceFactory.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation

class PhotoServiceFactory {
    
    private static let INSTANCE = PhotoServiceFactory()
    
    private let photoGalleryService = PhotoGalleryService()
    
    enum SourceType {
        case GALLERY
        case ZCLOUD
    }
    
    public static func singleton() -> PhotoServiceFactory{
        return INSTANCE
    }
    
    public func get(_ sourceType: SourceType) -> PhotoService {
        switch sourceType {
        default:
            return photoGalleryService
        }
    }
    
    
    
}
