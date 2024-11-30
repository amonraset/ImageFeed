//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by sm on 27.11.2024.
//

import Foundation

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    var authToken: String? {
        get {
            OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
    
    private let urlSession =  URLSession.shared
    private let decoder = JSONDecoder()
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let request = makeOAuthTokenRequest(code: code)
        
        let task = urlSession.data(for: request) {[weak self] result in
            
            guard let self else { preconditionFailure("Error: self is nil") }
            
            switch result {
            case .success(let data):
                do {
                    let OAuthTokenResponseBody = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    self.authToken = OAuthTokenResponseBody.accessToken
                    completion(.success(OAuthTokenResponseBody.accessToken))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest {
        guard let baseURL = URL(string: "https://unsplash.com") else {
            preconditionFailure("Error: invalid base URL")
        }
        guard let url = URL(
            string: "/oauth/token"
            + "?client_id=\(Constants.accessKey)"
            + "&&client_secret=\(Constants.secretKey)"
            + "&&redirect_uri=\(Constants.redirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            relativeTo: baseURL
        ) else {
            preconditionFailure("Error: invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}
