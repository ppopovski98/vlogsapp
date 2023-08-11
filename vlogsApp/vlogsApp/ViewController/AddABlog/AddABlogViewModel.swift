//
//  AddABlogViewModel.swift
//  vlogsApp
//
//  Created by Petar Popovski on 10.8.23.
//

import Foundation
import UIKit

class AddABlogViewModel {
    
    private var firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func uploadBlog (blog: Blog, image: String, completion: @escaping (Bool) -> Void) {
        guard let selectedImage = blog.image
        else {
            completion(false)
            return
        }
        
        let uploadCompletion: (Bool) -> Void = { success in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        firebaseManager.uploadData(
            title: blog.title,
            description: blog.description,
            image: selectedImage,
            isFavourite: blog.isFavourite,
            category: blog.category,
            timestamp: blog.timestamp,
            completion: uploadCompletion)
    }
}
