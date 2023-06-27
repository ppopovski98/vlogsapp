//
//  FirebaseManager.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.6.23.
//

import Foundation
import FirebaseFirestore
import SDWebImage
import FirebaseFirestoreSwift
import FirebaseCore
import FirebaseStorage

class FirebaseManager {
    
    let db = Firestore.firestore()
    var dataSource = [AddABlogModel]()
    let reference = Storage.storage()
    
    func dowloadPhoto(path: String, completion: @escaping (Data) -> Void) {
        reference.reference(withPath: path).getData(maxSize: (1 * 1024 * 1024)) { data, error in
            if let err = error {
                print(err)
            } else {
                if let image  = data {
                    completion(image)
                }
            }
        }
    }
    
    func getDataFromFirebase(completion: @escaping ([AddABlogModel]) -> Void) {
        
        db.collection("Posts").getDocuments { querySnapshot, err in
            guard let querySnapshot = querySnapshot else { return }
            for document in querySnapshot.documents {
                let data = document.data()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let blogPost = try JSONDecoder().decode(AddABlogModel.self, from: jsonData)
                    self.dataSource.append(blogPost)
                } catch {
                    print("Error")
                }
            }
            completion(self.dataSource)
        }
    }
    
    func uploadPhoto(title: String, description: String, image: String, completion: @escaping (Bool) -> Void) {
        let storageRef = Storage.storage().reference()
        let path = "Posts/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        guard let imageData = Data(base64Encoded: image) else {
            print("Invalid image data.")
            completion(false)
            return
        }
        
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
    
    
    
    func retrieveData(completion: @escaping ([AddABlogModel]) -> Void) {
        
        db.collection("Posts").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error retrieving photos: \(error)")
                completion([])
                return
            }
            
            guard let querySnapshot = querySnapshot else {
                completion(self.dataSource)
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
                    self.dataSource.append(blogPost)
                }
            }
            
            completion(self.dataSource)
        }
    }
}
