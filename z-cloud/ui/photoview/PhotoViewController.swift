//
//  PhotoViewController.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view = ImageZoomView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), image: #imageLiteral(resourceName: "sample-image-2"))
        self.view.backgroundColor = UIConfiguration.singleton().color.mainBackground
    }

}
