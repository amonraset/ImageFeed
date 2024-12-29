//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by sm on 27.11.2024.
//

import Foundation

enum AuthServiceError: Error {
    case invalidRequest
}

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    
    var authToken: String? {
        get {
            OAuth2TokenStorage().token
        } set {
            OAuth2TokenStorage().token = newValue
        }
    }
    
    private let urlSession =  URLSession.shared
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard let request = makeOAuthTokenRequest(code: code) else {
            print("Error: request is nil")
            return
        }
        
        let task = urlSession.data(for: request) { [weak self] result in
            
            guard let self else {
                print("Error: self is nil")
                return
            }
            
            switch result {
            case .success(let data):
                do {
                    let OAuthTokenResponseBody = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    self.authToken = OAuthTokenResponseBody.accessToken
                    completion(.success(OAuthTokenResponseBody.accessToken))
                } catch {
                    print("decoding error:", error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print("error:", error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest? {
        
        guard var urlComponents = URLComponents(string: Constants.baseURLString) else {
                print("Error: invalid base URL")
                return nil
            }
            
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: Constants.accessKey),
                URLQueryItem(name: "client_secret", value: Constants.secretKey),
                URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "grant_type", value: "authorization_code")
            ]
            
            guard let url = urlComponents.url else {
                print("Invalid URL")
                return nil
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
}
