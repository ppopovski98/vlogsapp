//
//  RacingScreenViewModel.swift
//  vlogsApp
//
//  Created by Petar Popovski on 10.8.23.
//

import Foundation

class RacingScreenViewModel {
    
    private var firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    var dataSource: [Blog] = []
    
    func fetchData(completion: @escaping ([Blog]) -> Void) {
        firebaseManager.getDataFromFirebase(forCategory: "racing", completion: { dataSourceForTableView in
            self.dataSource = dataSourceForTableView
            completion(self.dataSource)
        })
    }
    
    func addToFavourites(blog: Blog, indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        
        var updatedBlog = blog
        updatedBlog.isFavourite.toggle()
        
        firebaseManager.addToFavourites(updatedBlog) { success in
            completion(success)
        }
    }
}
