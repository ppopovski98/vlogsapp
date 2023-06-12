//
//  Extension+UIStackView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
    }
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, layoutMargins: UIEdgeInsets) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.layoutMargins = layoutMargins
        self.isLayoutMarginsRelativeArrangement = true
    }
}
