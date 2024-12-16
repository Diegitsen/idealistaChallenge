//
//  UIViewExtensions.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import UIKit

extension UIView {
    var viewWidth: CGFloat {
        return self.frame.size.width
    }

    var viewHeight: CGFloat {
        return self.frame.size.height
    }
    
    func dropShadow(scale: Bool = true) {
        self.layoutIfNeeded()
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 3
        layer.cornerRadius = 9
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

