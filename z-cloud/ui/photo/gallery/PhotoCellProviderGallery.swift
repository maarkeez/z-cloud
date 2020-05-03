//
//  PhotoCellProviderGallery.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 03/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class PhotoCellProviderGallery : PhotoCellProvider {
    
    private let mainProvider = PhotoCellMainProvider()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, photoService: PhotoService) -> UICollectionViewCell {
        return mainProvider.collectionView(collectionView, cellForItemAt: indexPath, photoService: photoService)
    }
    
    func loadCellImage(_ cell: PhotoGalleryCell, indexPath: IndexPath, photoService: PhotoService) {
        photoService.getPhoto(at: indexPath.row){(image) in
            cell.myImage.image=image
        }
    }
    
    
    
}
