//
//  UserProfile.swift
//  ImageFeed
//
//  Created by sm on 25.12.2024.
//

import Foundation

struct userPlaceholder {
    let avatar = "personPlaceholder.png"
}

struct ProfileResult: Decodable {
    let username: String
    let first_name: String
    let last_name: String?
    let loginName: String?
    let bio: String?
}

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String
}

struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}

struct UserResult: Decodable {
    let profile_image: ProfileImage
}
