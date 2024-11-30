//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by sm on 27.11.2024.
//

import UIKit

final class SplashViewController: UIViewController, AuthViewControllerDelegate {
    
    
    private let ShowAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"

    private let oauth2Service = OAuth2Service.shared
    private let storage = OAuth2TokenStorage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("splash")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print (" splash viewDidppear")

        if  storage.token != nil {
            switchToTabBarController()
            print ("Token: \(storage.token)")
        } else {
            performSegue(withIdentifier: ShowAuthenticationScreenSegueIdentifier, sender: nil)
            print ("No Token \(storage.token)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
    
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == ShowAuthenticationScreenSegueIdentifier {
                guard
                    let navigationController = segue.destination as? UINavigationController,
                    let viewController = navigationController.viewControllers[0] as? AuthViewController
                else { fatalError("Failed to prepare for \(ShowAuthenticationScreenSegueIdentifier)") }
                viewController.delegate = self
            } else {
                super.prepare(for: segue, sender: sender)
            }
        }
        
        func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.fetchOAuthToken(code)
            }
        }

        private func fetchOAuthToken(_ code: String) {
            oauth2Service.fetchOAuthToken(code) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.switchToTabBarController()
                case .failure:
                    // TODO [Sprint 11]
                    break
                }
            }
        }
}

//extension SplashViewController {
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == ShowAuthenticationScreenSegueIdentifier {
//            guard
//                let navigationController = segue.destination as? UINavigationController,
//                let viewController = navigationController.viewControllers[0] as? AuthViewController
//            else { fatalError("Failed to prepare for \(ShowAuthenticationScreenSegueIdentifier)") }
//            viewController.delegate = self
//        } else {
//            super.prepare(for: segue, sender: sender)
//        }
//    }
//}
//
//extension SplashViewController {
//    
//    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
//        dismiss(animated: true) { [weak self] in
//            guard let self = self else { return }
//            self.fetchOAuthToken(code)
//        }
//    }
//
//    private func fetchOAuthToken(_ code: String) {
//        oauth2Service.fetchOAuthToken(code) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success:
//                self.switchToTabBarController()
//            case .failure:
//                // TODO [Sprint 11]
//                break
//            }
//        }
//    }
//}
