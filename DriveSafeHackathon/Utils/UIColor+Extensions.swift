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
	
	static func driveSafeColor(string color: String?) -> UIColor {
		guard let color = color else { return UIColor.gray }
		
		switch color {
		case "YELLOW": return UIColor(red: 232.0/255.0, green: 215.0/255.0, blue: 22.0/255.0, alpha: 1.0)
		case "RED": return UIColor(red: 216.0/255.0, green: 47.0/255.0, blue: 44.0/255.0, alpha: 1.0)
		case "GREEN": return UIColor(red: 67.0/255.0, green: 207.0/255.0, blue: 35.0/255.0, alpha: 1.0)
		default: return UIColor.gray
		}
	}
}
