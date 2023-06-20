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
    
    
    func getDataFromFirebase(completion: @escaping ([AddABlogModel]) -> Void) {
        db.collection("Posts").getDocuments { querySnapshot, err in
            guard let querySnapshot = querySnapshot else { return }
            var dataSource = [AddABlogModel]()
            for document in querySnapshot.documents {
                let data = document.data()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let blogPost = try JSONDecoder().decode(AddABlogModel.self, from: jsonData)
                    dataSource.append(blogPost)
                } catch {
                    print("Error")
                }
            }
            completion(dataSource)
        }
    }
    
    func uplaodPhotoToDataBase(_ title: String,_ description: String,_ image: String, completion: @escaping (Bool) -> Void) {
        
        
    }
}
