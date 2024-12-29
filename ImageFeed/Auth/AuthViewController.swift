//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by sm on 16.11.2024.
//
import UIKit
import SwiftKeychainWrapper

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    private let showWebViewSegueIdentifier = "ShowWebView"
    
    weak var delegate: AuthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        print ("Load AuthViewController")
    }
    
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back_button")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black (iOS)")
    }
    
    private func showAuthErrorAlert() {
        let alert = UIAlertController(
            title: "Что-то пошло не так(",
            message: "Не удалось войти в систему",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else {
                assertionFailure("Failed to prepare for \(showWebViewSegueIdentifier)")
                return
            }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        
        UIBlockingProgressHUD.show()
        
        //__________-__________________________
//    OAuth2Service.shared.fetchOAuthToken(code: code) { [weak self] result in
//    
//    UIBlockingProgressHUD.dismiss()
//
//            switch result {
//            case .success(let receivedToken):
//                guard let self else { return }
//                OAuth2TokenStorage.shared.token = receivedToken
//                delegate?.authViewController(self, didAuthenticateWithCode: code)
//            case .failure(let error):
//                switch error {
//                case NetworkError.httpStatusCode(let statusCode):
//                    print(">>> [OAuth2Service] Network error. HTTP status code \(statusCode) was received")
//                case NetworkError.urlRequestError(let error):
//                    print(">>> [OAuth2Service] Network error. URL Request error: \(error.localizedDescription)")
//                case NetworkError.urlSessionError:
//                    print(">>> [OAuth2Service] Network error. URL Session error: \(error.localizedDescription)")
//                case NetworkError.invalidData(let invalidData):
//                    print(">>> [OAuth2Service] Network error. Decoding failed: \(error.localizedDescription); Received data: \(invalidData)")
//                case AuthServiceError.invalidRequest:
//                    print(">>> [OAuth2Service] AuthService error. Failed to complete request")
//                case AuthServiceError.extraRequest:
//                    print(">>> [OAuth2Service] Attempting to execute a request instead of the current one")
//                default:
//                    print(">>> [OAuth2Service] Error: \(error.localizedDescription)")
//                }
//                
//                self?.showAuthErrorAlert()
//            }
//        }
        //__________-__________________________
        
       delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}

