//
//  AuthManager.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import Foundation
import Security

protocol AuthManagerProtocol {
    init(tokenKey: String)
    func saveToken(_ token: String)
    func getToken() -> String?
    func deleteToken()
}

final class AuthManager: AuthManagerProtocol {
    init(tokenKey: String) {
        self.tokenKey = tokenKey
    }
    
    private var tokenKey = "auth_token"

    func saveToken(_ token: String) {
        let data = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary) // Remove old token
        SecItemAdd(query as CFDictionary, nil)
    }

    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)

        guard let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
