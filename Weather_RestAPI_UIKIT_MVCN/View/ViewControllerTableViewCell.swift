//
//  ViewControllerTableViewCell.swift
//  Weather_RestAPI_UIKIT_MVCN
//
//  Created by Ignacio Arias on 2020-07-13.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    let cityName: UILabel = {
        let lbl = UILabel()
        lbl.text = "city Name"
        
        return lbl
    }()
    
    let citySpeed: UILabel = {
        let lbl = UILabel()
        lbl.text = "city Speed"
        
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cityName)
        addSubview(citySpeed)
        
        cityName.setUpAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 15, leftPadding: 5, bottomPadding: 0, rightPadding: 0, width: frame.width, height: 20)
        
        citySpeed.setUpAnchor(top: cityName.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 15, leftPadding: 5, bottomPadding: 0, rightPadding: 0, width: frame.width, height: 20)

    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error with the cell")
    }
}
