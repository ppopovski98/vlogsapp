//
//  GamingScreenViewModel.swift
//  vlogsApp
//
//  Created by Petar Popovski on 9.8.23.
//

import Foundation

class GamingScreenViewModel {
    private var firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    var dataSource: [Blog] = []
    
    func fetchData(completion: @escaping ([Blog]) -> Void) {
        firebaseManager.getDataFromFirebase(forCategory: "gaming", completion: { dataSourceForTableView in
            self.dataSource = dataSourceForTableView
            completion(self.dataSource)
        })
    }
}
