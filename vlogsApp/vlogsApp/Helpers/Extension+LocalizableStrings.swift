//
//  Extension+LocalizableStrings.swift
//  vlogsApp
//
//  Created by Petar Popovski on 6.9.23.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
