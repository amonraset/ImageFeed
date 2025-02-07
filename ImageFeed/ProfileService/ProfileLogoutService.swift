//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by sm on 04.02.2025.
//
import Foundation
import WebKit

final class ProfileLogoutService {
    static let shared = ProfileLogoutService()
    
    private init() {}
    
    func logout() {
        cleanCookies()
        cleanData()
        transitionToAuthViewController()
    }
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    private func cleanData() {
        OAuth2TokenStorage.shared.token = nil
        ProfileService.shared.deleteProfile()
        ProfileImageService.shared.deleteProfileImage()
//        ImageListServise.shared.deletePhotos()
    }
    
    private func transitionToAuthViewController() {
        if let window = UIApplication.shared.windows.first {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let authVC = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController {
                window.rootViewController = authVC
                window.makeKeyAndVisible()
            }
        }
    }
    
}
