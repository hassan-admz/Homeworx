//
//  AuthService.swift
//  Homeworx
//
//  Created by user on 27/8/23.
//

import Foundation
import Firebase
//import FirebaseStorage

struct AuthService {
    
    struct AuthCredentials {
        let profileImage: UIImage
        let username: String
        let fullname: String
        let email: String
        let password: String
    }
    
    static let shared = AuthService()
    
    func logInUser(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?)->Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(withCredentials credentials: AuthCredentials, completion: @escaping  (Error?)->Void) {
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    completion(error)
                    print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
                    
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data = ["email": credentials.email,
                            "fullname": credentials.fullname,
                            "profileImageURL": imageURL,
                            "uid": uid,
                            "username": credentials.username] as [String: Any]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
