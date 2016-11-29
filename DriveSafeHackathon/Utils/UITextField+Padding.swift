//
//  UITextField+Padding.swift
//  MY Renault
//
//  Created by lng3578 on 25/11/2016.
//  Copyright © 2016 VISEO. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
	func setLeftPadding(_ padding: CGFloat) {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.size.height))
		leftView = paddingView
		leftViewMode = .always
	}
	
	func setRightPadding(_ padding: CGFloat) {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.size.height))
		rightView = paddingView
		rightViewMode = .always
	}
}
