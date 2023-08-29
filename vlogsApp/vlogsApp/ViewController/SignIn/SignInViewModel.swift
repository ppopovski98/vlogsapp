//
//  SignInViewModel.swift
//  vlogsApp
//
//  Created by Petar Popovski on 17.8.23.
//

import Foundation
import FirebaseAuth

class SignInViewModel {
    
    var email = ""
    var password = ""
    
    func isPasswordTooShort(_ password: String) -> Bool{
        return password.count < 6
    }
    
    func isEmailTooShort(_ username: String) -> Bool {
        return username.count < 6
    }
    
    func logIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        if isEmailTooShort(email) {
            completion (false, "Email is too short")
            return
        }
        
        if isPasswordTooShort(password) {
            completion (false, "Password is too short")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                completion (true, nil)
            } else {
                completion (false, error?.localizedDescription ?? "Error")
            }
        }
    }
}
