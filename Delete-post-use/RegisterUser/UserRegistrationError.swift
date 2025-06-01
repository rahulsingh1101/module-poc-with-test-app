//
//  UserRegistrationError.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import Foundation

enum UserRegistrationError: Error {
    case networkFailure
    case invalidInput
    case userAlreadyExists
    case unknown
}
