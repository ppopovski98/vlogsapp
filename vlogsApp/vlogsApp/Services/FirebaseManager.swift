//
//  FirebaseManager.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.6.23.
//

import Foundation
import FirebaseFirestore
import FirebaseCore


class FirebaseManager {
    
    let database = Firestore.firestore()
    
    func writeData(text: String) {
        let docRef = database.document("example/testexample")
        docRef.setData(["text": text])
    }
}
