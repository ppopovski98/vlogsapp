//
//  BlogModel.swift
//  vlogsApp
//
//  Created by Petar Popovski on 13.6.23.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

struct Blog: Codable {
    var blogID: String?
    var title: String
    var description: String
    var image: String?
    var isFavourite: Bool
    var category: String
    var timestamp: Double
}
