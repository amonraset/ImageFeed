//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by sm on 11.12.2024.
//
import Foundation

enum ProfileImageServiceError: Error {
    case invalidRequest
}

final class ProfileImageService {
    
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImage")
    static let shared = ProfileImageService()
    private init() {}
    
    private var task: URLSessionTask?
    private(set) var avatarURL: String?
    
    func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        if task != nil {
            print("ProfileImageService: Invalid request, already fetching")
            completion(.failure(ProfileImageServiceError.invalidRequest))
            return
        }
        
        guard
            let request = makeProfileImageRequest(username: username)
        else {
            print("ProfileImageService: Invalid request, unable to create the request")
            completion(.failure(ProfileImageServiceError.invalidRequest))
            return
        }
        
        let urlSession = URLSession.shared
        let task = urlSession.objectTask(for: request) { (result: Result<UserResult, Error>) in
            
            switch result {
            case .success(let userResult):
                let profileImageURL = userResult.profile_image.small
                self.avatarURL = profileImageURL
                NotificationCenter.default
                    .post(
                        name: ProfileImageService.didChangeNotification,
                        object: self,
                        userInfo: ["URL": profileImageURL]
                    )
                completion(.success(userResult.profile_image.small))
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }
        
        self.task = task
        task.resume()
    }
    
    private func makeProfileImageRequest(username: String) -> URLRequest? {
        guard
            let token = OAuth2TokenStorage.shared.token
        else { return nil }
        
        guard
            let url = URL(
                string: "/users/\(username)"
                + "?client_id=\(Constants.accessKey)",
                relativeTo: Constants.defaultBaseURL
            )
        else {
            assertionFailure("ProfileImageService/makeProfileImageRequest: Invalid URL for username: \(username)")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
}
