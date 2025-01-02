//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by sm on 27.11.2024.
//

import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "Vector.png")
        return logoImage
    }()
    
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let mainStoryboardName = "Main"
    private let tabBarControllerIdentifier = "TabBarController"
    private let oauth2Service = OAuth2Service.shared
    private let storage = OAuth2TokenStorage()
    
    private let profileService = ProfileService.shared
    private var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if let token = storage.token {
            fetchProfile(token)
        } else {
            switchToAuthViewController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setUpScreen() {
        view.addSubview(logoImage)
        view.backgroundColor = UIColor.ypBlackIOS
        
        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 75),
            logoImage.heightAnchor.constraint(equalToConstant: 77.68),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: mainStoryboardName, bundle: .main)
            .instantiateViewController(withIdentifier: tabBarControllerIdentifier)
        window.rootViewController = tabBarController
    }
}

// MARK: - AuthViewControllerDelegate

extension SplashViewController: AuthViewControllerDelegate {
    
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        UIBlockingProgressHUD.show()
        
        oauth2Service.fetchOAuthToken(code) { [weak self] result in
            
            UIBlockingProgressHUD.dismiss()
            
            guard let self = self else {
                print("SplashViewController: fetchOAuthToken error: self is nil")
                return
            }
            
            switch result {
            case .success:
                fetchProfileWithStoredToken()
                self.switchToTabBarController()
            case .failure:
                self.showAuthErrorAlert()
                print("SplashViewController: fetchOAuthToken error: result is failure")
                break
            }
        }
    }
    
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
    }
    
    private func fetchProfileWithStoredToken() {
        guard let token = storage.token else {
            return
        }
        fetchProfile(token)
    }
    
    private func fetchProfile(_ token: String) {
        UIBlockingProgressHUD.show()
        profileService.fetchProfile(token) { [weak self] result in
            
            print("SplashViewController: func fetchProfile - Fetching profile")
            
            UIBlockingProgressHUD.dismiss()
            
            guard let self else { return }
            
            switch result {
            case .success(let profile):
                username = profile.username
                guard let username else { return }
                ProfileImageService.shared.fetchProfileImageURL(username: username) { _ in }
                print("SplashViewController: func fetchProfile - Fetching profile completed")
                switchToTabBarController()
            case .failure:
                showAuthErrorAlert()
                print("SplashViewController: func fetchProfile - Error: Fetching profile failed")
            }
        }
    }
    
    private func switchToAuthViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let authViewController = storyboard.instantiateViewController(
            withIdentifier: "AuthViewController"
        ) as? AuthViewController else { return }
        
        authViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: authViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true, completion: nil)
    }
}
