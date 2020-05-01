//
//  AttachmentHandler.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Photos

class PhotoAccessService: NSObject{
    static let shared = PhotoAccessService()
    fileprivate var currentVC: UIViewController?
    
    //MARK: - Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    var videoPickedBlock: ((NSURL) -> Void)?
    var filePickedBlock: ((URL) -> Void)?

    
    //MARK: - Constants
    struct Constants {
        static let phoneLibrary = "Phone Library"
        static let actionFileTypeHeading = "Add a File"
        static let actionFileTypeDescription = "Choose a filetype to add..."
        
        static let alertForPhotoLibraryMessage = "z-cloud needs photo access, tap settings and turn on Photo Library Access."
        
        static let settingsBtnTitle = "Settings"
        static let cancelBtnTitle = "Cancel"
        
    }
    
    //MARK: - Authorisation Status
    // This is used to check the authorisation status whether user gives access to import the image, photo library, video.
    // if the user gives access, then we can import the data safely
    // if not show them alert to access from settings.
    func authorisationStatus(vc: UIViewController){
        currentVC = vc
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
              break
        case .denied:
            self.addAlertForSettings()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status != PHAuthorizationStatus.authorized{
                    self.addAlertForSettings()
                }
            })
        case .restricted:
            self.addAlertForSettings()
        default:
            break
        }
    }
    
    
    //MARK: - SETTINGS ALERT
    func addAlertForSettings(){
        var alertTitle: String = ""
        alertTitle = Constants.alertForPhotoLibraryMessage
        
        let alertController = UIAlertController (title: alertTitle , message: nil, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: Constants.settingsBtnTitle, style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: Constants.cancelBtnTitle, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        currentVC?.present(alertController , animated: true, completion: nil)
    }
}
