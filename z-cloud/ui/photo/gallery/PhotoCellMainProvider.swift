//
//  PhotoCellMainProvider.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 03/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class PhotoCellMainProvider {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, photoService: PhotoService) -> PhotoGalleryCell {
           
           let cell = collectionView.dequeueReusableCell(
               withReuseIdentifier: PhotoGalleryCell.reuseIdentifier,
               for: indexPath)
               as! PhotoGalleryCell
           
           cell.resetCell()
           
           return cell
       }
}

