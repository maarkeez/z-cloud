//
//  UIConfiguration.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class UIConfiguration{
    
    private static let INSTANCE = UIConfiguration()
    let color = Color()
    
    static func singleton() -> UIConfiguration{
        return .INSTANCE
    }
    
    class Color{
        let mainBackground = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        
        let selectedBarButtonItem = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        let unSelectedBarButtonItem = UIColor.lightGray
        let pinkBarButtonItem = #colorLiteral(red: 0.8784313725, green: 0.1294117647, blue: 0.5411764706, alpha: 1)
        
        let navBarBackgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        
    }
    
}
