//
//  PhotoGalleryCell.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import UIKit

class PhotoGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        backgroundColor = .black
        myImage.contentMode = .scaleAspectFill
        myImage.image=#imageLiteral(resourceName: "image-placeholder")
    }
}
