
//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by sm on 27.11.2024.
//

import Foundation
import SwiftKeychainWrapper

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case createdAt = "created_at"
    }
}

final class OAuth2TokenStorage {
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: Keys.token.rawValue)
        } set {
            guard let newValue else {
                print ("OAuth Token Storage: token is nil")
                return
            }
            KeychainWrapper.standard.set(newValue, forKey: Keys.token.rawValue)
            
        }
    }
    
    static let shared = OAuth2TokenStorage()
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case token
    }
}

