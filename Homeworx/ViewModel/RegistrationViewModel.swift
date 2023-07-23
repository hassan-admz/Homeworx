//
//  RegistrationViewModel.swift
//  Homeworx
//
//  Created by Hassan Mayers on 22/7/23.
//

import Foundation

struct RegistrationViewModel {
    var fullName: String?
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return fullName?.isEmpty == false
        && email?.isEmpty == false
        && password?.isEmpty == false
    }
}
