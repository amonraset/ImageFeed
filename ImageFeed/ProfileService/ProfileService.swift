//
//  ProfileService.swift
//  ImageFeed
//
//  Created by sm on 10.12.2024.
//

import Foundation

enum ProfileServiceError: Error {
    case extraRequest
    case invalidRequest
}

final class ProfileService {
    
    static let shared = ProfileService()
    private init() {}
    
    private var task: URLSessionTask?
    private(set) var profile: Profile?
    
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        if task != nil {
            print("ProfileService: The request is already in progress, no extra request needed")
            completion(.failure(ProfileServiceError.extraRequest))
            return
        }
        
        guard let request = makeUsersProfileRequest(token: token) else {
            print("ProfileService: Failed to create the request")
            completion(.failure(ProfileServiceError.invalidRequest))
            return
        }
        
        print("ProfileService/ Request:", request)
        
        let urlSession = URLSession.shared
        let task = urlSession.objectTask(for: request) { (result: Result<ProfileResult, Error>) in
            switch result {
            case .success(let userInfo):
                
                let profile = Profile(
                    username: userInfo.username,
                    name: "\(userInfo.first_name) \(userInfo.last_name ?? userPlaseholder().name)",
                    email: userInfo.email ?? userPlaseholder().email,
                    bio: userInfo.bio ?? userPlaseholder().bio
                )
                self.profile = profile
                completion(.success(profile))
                
            case .failure(let error):
                completion(.failure(error))
            }
            
            self.task = nil
        }
        
        self.task = task
        task.resume()
    }
    
    private func makeUsersProfileRequest(token: String) -> URLRequest? {
        guard
            let url = URL(
                string: "/me"
                + "?client_id=\(Constants.accessKey)",
                relativeTo: Constants.defaultBaseURL
            )
        else {
            assertionFailure("ProfileService: Failed to create URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
}
