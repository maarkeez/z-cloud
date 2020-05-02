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
    
    override func viewWillAppear(_ animated: Bool) {
        myMainView.backgroundColor = UIConfiguration.singleton().color.mainBackground
        myHostLbl.textColor = UIConfiguration.singleton().color.pinkBarButtonItem
        myPortLbl.textColor = UIConfiguration.singleton().color.pinkBarButtonItem
    }

}
