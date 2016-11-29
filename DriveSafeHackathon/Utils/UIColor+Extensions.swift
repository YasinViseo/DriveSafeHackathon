//
//  UIColor+Renault.swift
//  MY Renault
//
//  Created by lng3578 on 03/11/2016.
//  Copyright © 2016 VISEO. All rights reserved.
//

import UIKit

extension UIColor {
    static func driveSafePink() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 48.0/255.0, blue: 110.0/255.0, alpha: 1.0)
    }
	
	static func driveSafeBlue() -> UIColor {
		return UIColor(red: 40.0/255.0, green: 154.0/255.0, blue: 224.0/255.0, alpha: 1.0)
	}
	
	static func driveSafeTextColor() -> UIColor {
		return UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
	}
	
	static func driveSafeLightTextColor() -> UIColor {
		return UIColor(red: 139.0/255.0, green: 153.0/255.0, blue: 159.0/255.0, alpha: 1.0)
	}
	
    static func error() -> UIColor {
        return UIColor(red: 1.0, green: 175.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    }
}
