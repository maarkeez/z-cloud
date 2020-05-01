//
//  PhotoViewController.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var myDisplayImage : UIImage?
    
    // MARK: - Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Needed to center the image in the phone
        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        self.view = ImageZoomView(frame: CGRect(x: 0, y: -navBarHeight, width: self.view.frame.width, height: self.view.frame.height), image: myDisplayImage!)
        self.view.backgroundColor = UIConfiguration.singleton().color.mainBackground
    }

}
