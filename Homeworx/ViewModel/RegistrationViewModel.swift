//
//  RegistrationViewModel.swift
//  Homeworx
//
//  Created by Hassan Mayers on 22/7/23.
//

import Foundation

struct RegistrationViewModel {
    var username: String?
    var fullName: String?
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return username?.isEmpty == false
        && fullName?.isEmpty == false
        && email?.isEmpty == false
        && password?.isEmpty == false
    }
}
