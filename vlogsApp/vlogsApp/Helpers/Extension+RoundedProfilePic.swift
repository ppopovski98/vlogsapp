//
//  Extension+RoundedProfilePic.swift
//  vlogsApp
//
//  Created by Petar Popovski on 28.6.23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func makeRounded() {
        
        contentMode = UIView.ContentMode.scaleAspectFit
        frame.size.width = 200
        frame.size.height = 200
        center = self.center
        layer.cornerRadius = 95
        clipsToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor(named: "textField".localized())?.cgColor
    }
}
