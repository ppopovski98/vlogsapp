//
//  FirebaseManager.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.6.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore


class FirebaseManager {
    
    let db = Firestore.firestore()
    
    func writeData(text: String) {
        let docRef = db.document("example/testexample")
        docRef.setData(["text": text])
    }
    
    
    func getDataFromFirebase(completion: @escaping ([Model]) -> Void) {
        db.collection("Posts").getDocuments { querySnapshot, err in
            guard let querySnapshot = querySnapshot else { return }
            for document in querySnapshot.documents {
                let data = document.data()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let blogPost = try JSONDecoder().decode(Model.self, from: jsonData)
                    var dataSource = [Model]()
                    dataSource.append(blogPost)
                    completion(dataSource)
                } catch {
                    print("Error")
                }
            }
        }
    }
}
