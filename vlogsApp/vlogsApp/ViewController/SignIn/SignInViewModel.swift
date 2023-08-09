//
//  SignInViewModel.swift
//  vlogsApp
//
//  Created by Petar Popovski on 9.8.23.
//

import Foundation
import FirebaseAuth

class SignInViewModel {
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
