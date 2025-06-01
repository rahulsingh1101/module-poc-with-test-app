//
//  RegistrationError.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import Foundation

struct RegistrationError: Decodable {
    let title, message, stack: String
}
