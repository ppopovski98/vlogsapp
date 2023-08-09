//
//  RegisterViewModel.swift
//  vlogsApp
//
//  Created by Petar Popovski on 9.8.23.
//

import Foundation
import FirebaseAuth

class RegisterViewModel {
    func createAccount(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
