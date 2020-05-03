//
//  PhotoGalleryCellProvider.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 03/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoCellProvider {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
