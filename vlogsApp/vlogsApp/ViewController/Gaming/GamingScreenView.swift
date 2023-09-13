//
//  GamingScreenView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.8.23.
//

import UIKit
import SnapKit

class GamingScreenView: MainView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        mainScreenConfigUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
