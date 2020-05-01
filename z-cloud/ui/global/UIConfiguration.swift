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
    }

}
