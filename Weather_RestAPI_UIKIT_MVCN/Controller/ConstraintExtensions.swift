//
//  ConstraintExtensions.swift
//  Weather_RestAPI_UIKIT_MVCN
//
//  Created by Ignacio Arias on 2020-07-11.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import UIKit

extension UIView {

    //Very handy extension for a view and anchor its content, with padding, width and height.
    func setUpAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat, width: CGFloat, height: CGFloat) {

    translatesAutoresizingMaskIntoConstraints = false

    if let top = top {
        topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
    }

    if let left = left {
        leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
    }

    if let bottom = bottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
    }

    if let right = right {
        rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
    }

    if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
