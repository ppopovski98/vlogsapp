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
    let reference = Storage.storage()
    
    
    func getDataFromFirebase(forCategory category: String?, completion: @escaping ([Blog]) -> Void) {
        
        var query: Query = db.collection("Posts")
        var dataSource = [Blog]()
        
        if let category = category {
            query = query.whereField("category", isEqualTo: category)
        }
        
        query.getDocuments { querySnapshot, err in
            guard let querySnapshot = querySnapshot else { return }
            for document in querySnapshot.documents {
                let data = document.data()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let blogPost = try JSONDecoder().decode(Blog.self, from: jsonData)
                    dataSource.append(blogPost)
                } catch {
                    print("Error")
                }
            }
            completion(dataSource)
        }
    }
    
    func uploadData(title: String, description: String, image: String, isFavourite: Bool, category: String, timestamp: Double, completion: @escaping (Bool) -> Void) {
        let storageRef = Storage.storage().reference()
        let path = "Posts/\(UUID().uuidString).jpg"
        let blogPath = UUID().uuidString
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
                "blogID": blogPath,
                "title": title,
                "description": description,
                "image": path,
                "isFavourite": isFavourite,
                "category": category,
                "timestamp": timestamp
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
    
    
    
    func dowloadPhoto(path: String, completion: @escaping (URL) -> Void) {
                // Replace "your_image_path.jpg" with the actual path of the image in Firebase Storage
                let imageRef = Storage.storage().reference().child(path)

                // Get the download URL of the image
                imageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                    } else {
                        if let downloadURL = url {
                            print("Download URL: \(downloadURL)")
                            completion(downloadURL)
                            // Here you can use the downloadURL to display the image or perform other tasks
                        }
                    }
                }
            }
    
    func updateBlogData(blogID: String, title: String, description: String, newTitle: String, newDescription: String, completion: @escaping (Error?) -> Void) {
        let blogRef = db.collection("Posts")
            .whereField("blogID", isEqualTo: blogID)
        
        blogRef.getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                completion(error)
                return
            }
            if let document = querySnapshot.documents.first {
                document.reference.updateData([
                    "title": newTitle,
                    "description": newDescription
                ]) { error in
                    completion(error)
                }
            } else {
                completion(error)
            }
        }
    }
}
