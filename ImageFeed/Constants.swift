//
//  Constants.swift
//  ImageFeed
//
//  Created by sm on 14.11.2024.
//

import UIKit

enum Constants {
    static let accessKey = "a9f2wjNRYbDDnHSPz26AOp-fxy0tqSaUYxIy3371R_c"
    static let secretKey = "sWGU0H5FvDUY35cQD-7guNc7GLmiVhnY4DbFihSL900"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let urlComponentToBaseProfile = "https://api.unsplash.com/me"
    static let urlComponentToPublicProfile = "/users/"
    static let baseURLString = "https://unsplash.com/oauth/token"
}

