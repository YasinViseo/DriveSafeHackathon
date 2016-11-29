//
//  UIApplication+TopViewController.swift
//  MY Renault
//
//  Created by lng3578 on 26/10/2016.
//  Copyright © 2016 Renault Nissan Alliance - ACMS. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = base as? UINavigationController {
            return topViewController(base: navigationController.visibleViewController)
        }
        
        if let tabBarController = base as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
