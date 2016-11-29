//
//  AlertGenerator.swift
//  DriveSafeHackathon
//
//  Created by Linh NGUYEN on 28/11/2016.
//  Copyright © 2016 VISEO. All rights reserved.
//

import Foundation
import UIKit

class AlertGenerator {
    
    static func displaySettingsAlert(title: String?, message: String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let settingsAlertAction = UIAlertAction(title: "Settings", style: .default) { (_)->() in
            if let settingsURL = URL(string: UIApplicationOpenSettingsURLString),
                UIApplication.shared.canOpenURL(settingsURL) == true {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsURL)
                }
            }
        }
        
        alertController.addAction(okAlertAction)
        alertController.addAction(settingsAlertAction)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    static func displayInfoAlert(title: String?, message: String?) {
        
        displayInfoAlert(title: title, message: message, handler: nil)
    }
    
    static func displayInfoAlert(title: String?, message: String?, handler:((UIAlertAction) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        
        alertController.addAction(okAlertAction)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    static func displayConfirmationAlert(title: String?,
                                         message: String?,
                                         yesHandler: ((UIAlertAction) -> Void)?,
                                         noHandler: ((UIAlertAction) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionNo = UIAlertAction(title: "No", style: .default, handler: noHandler)
        let actionYes = UIAlertAction(title: "Yes", style: .default, handler: yesHandler)
        
        alertController.addAction(actionNo)
        alertController.addAction(actionYes)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}
