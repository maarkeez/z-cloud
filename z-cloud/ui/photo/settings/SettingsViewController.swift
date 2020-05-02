//
//  SettingsViewController.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 02/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var myMainView: UIView!
    @IBOutlet weak var myHostLbl: UILabel!
    @IBOutlet weak var myPortLbl: UILabel!
    @IBOutlet weak var myHostText: UITextField!
    @IBOutlet weak var myPortText: UITextField!
    @IBOutlet weak var mySaveBtn: UIButton!
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        
        if let host = myHostText.text {
            
            if host != "" {
                let configuration = ZCloudApiConfigurationService.Configuration()
                configuration.apiHost = host
                configuration.apiPort = myPortText.text ?? ""
                
                ZCloudApiConfigurationService.singleton().set(configuration)
            }
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myMainView.backgroundColor = UIConfiguration.singleton().color.mainBackground
        myHostLbl.textColor = UIConfiguration.singleton().color.pinkBarButtonItem
        myPortLbl.textColor = UIConfiguration.singleton().color.pinkBarButtonItem
        mySaveBtn.backgroundColor = UIConfiguration.singleton().color.pinkBarButtonItem
        mySaveBtn.tintColor = .white
        
        let configuration = ZCloudApiConfigurationService.singleton().get()
        myHostText.text = configuration?.apiHost
        myPortText.text = configuration?.apiPort
    }
    
    
    // End editing when touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}
