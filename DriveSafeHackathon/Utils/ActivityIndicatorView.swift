//
//  ActivityIndicatorView.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 09/11/2016.
//  Copyright © 2016 VISEO. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
    
    convenience init() {
        self.init(activityIndicatorStyle: .whiteLarge)
    }
    
    private func configureForView(_ view: UIView) {
        if view.subviews.contains(self) {
            return
        }
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        layer.cornerRadius = 5.0
        hidesWhenStopped = true
        center = view.center
        isHidden = true
        view.addSubview(self)
    }
    
    func show(onView view: UIView, disableInteraction: Bool) {
        configureForView(view)
        
        if disableInteraction {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        
        startAnimating()
    }
    
    func show(onView view: UIView) {
        show(onView: view, disableInteraction: false)
    }
    
    func hide(remove: Bool) {
        stopAnimating()
        
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
        if remove {
            removeFromSuperview()
        }
    }
    
    func hide() {
        hide(remove: false)
    }
}
