
//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by sm on 27.11.2024.
//

import Foundation

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
            storage.string(forKey: Key.token.rawValue)
        }
        set {
            storage.set(newValue, forKey: Key.token.rawValue)
        }
    }
    
    private let storage: UserDefaults = .standard
    
    private enum Key: String {
        case token
    }

}
    

