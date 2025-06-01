//
//  NSObject+Extension.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 02/06/25.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
