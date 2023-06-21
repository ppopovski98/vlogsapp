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
import FirebaseStorage

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
    
    func uploadPhoto(title: String, description: String, image: String, completion: @escaping (Bool) -> Void) {
        let storageRef = Storage.storage().reference()
        
        guard let imageData = Data(base64Encoded: image) else {
            print("Invalid image data.")
            completion(false)
            return
        }

        let path = "Posts/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        let uploadTask = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading photo: \(error)")
                completion(false)
                return
            }

            self.db.collection("Posts").addDocument(data: [
                "title": title,
                "description": description,
                "image": path
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(false)
                } else {
                    print("Document added with ID")
                    completion(true)
                }
            }
        }
    }


    
    func retrievePhotos(completion: @escaping ([AddABlogModel]) -> Void) {
        
        db.collection("Posts").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error retrieving photos: \(error)")
                completion([])
                return
            }
            
            var dataSource = [AddABlogModel]()
            
            guard let querySnapshot = querySnapshot else {
                completion(dataSource)
                return
            }
            
            for document in querySnapshot.documents {
                let data = document.data()
                
                if let base64Image = data["image"] as? String {
                    let blogPost = AddABlogModel(
                        title: data["title"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        image: base64Image
                    )
                    dataSource.append(blogPost)
                }
            }
            
            completion(dataSource)
        }
    }
}
