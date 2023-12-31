//
//  LoginViewModel.swift
//  Homeworx
//
//  Created by Hassan Mayers on 22/7/23.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
        && password?.isEmpty == false
    }
}
