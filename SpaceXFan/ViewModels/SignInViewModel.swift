//
//  SignInViewModel.swift
//  SpaceXFan
//
//  Created by ggajulapati on 25/05/21.
//

import Foundation
import FirebaseAuth

class SignInViewModel {
        

    func valdiateEmail(emailAddress: String) -> Bool {
        return Util.isValidEmail(emailAddress)
    }
    func handleLoginTapped(emailAddress: String, password: String,completion: @escaping (Bool,Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (user, error) in
            if let firebaseError = error {
                print("Eerorr",firebaseError.localizedDescription)
                completion(false,firebaseError)
            }else {
                completion(true,nil)
            }
        }
    }

   
    
}
