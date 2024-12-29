//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by sm on 31.10.2024.
//

import UIKit
import Kingfisher


struct userPlaseholder {
    let name = "Екатерина Новикова"
    let email = "@ekaterina_nov"
    let bio = "Hello, world!"
    let avatar = "personPlaceholder.png"
}


final class ProfileViewController: UIViewController {
    
    
    private var profileImageServiceObserver: NSObjectProtocol?
    
    //    private var profile: userProfile? {
    //        ProfileService.shared.profile
    //    }
    
    private let userNameText = ProfileService.shared.profile?.name ?? userPlaseholder().name
    private let userEmailText = ProfileService.shared.profile?.email ?? userPlaseholder().email
    private let userTextWords = ProfileService.shared.profile?.bio ?? userPlaseholder().bio
    private let userPhoto = ProfileImageService.shared.avatarURL ?? userPlaseholder().avatar
    
    private let exitPictureName = "Exit.png"
    
    private lazy var buttonExit: UIButton = {
        let buttonExit = UIButton()
        buttonExit.setImage(UIImage(named: exitPictureName), for: .normal)
        buttonExit.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        buttonExit.translatesAutoresizingMaskIntoConstraints = false
        return buttonExit
    }()
    
    private lazy var profileImageView: UIImageView = {
        let profileImage = UIImage(named: userPhoto)
        let profileImageView = UIImageView(image: profileImage)
        let imageView = UIImageView(image: profileImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let userName = UILabel()
        userName.text = userNameText
        userName.font = .systemFont(ofSize: 23.0, weight: .medium)
        userName.textColor = .ypWhiteIOS
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()
    
    private lazy var userEmailLabel: UILabel = {
        let userEmailLabel = UILabel()
        userEmailLabel.text = userEmailText
        userEmailLabel.font = .systemFont(ofSize: 13.0, weight: .medium)
        userEmailLabel.textColor = .ypGrayIOS
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        return userEmailLabel
    }()
    
    private lazy var userTextLabel: UILabel = {
        let userTextLabel = UILabel()
        userTextLabel.text = userTextWords
        userTextLabel.font = .systemFont(ofSize: 13.0, weight: .medium)
        userTextLabel.textColor = .ypWhiteIOS
        userTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return userTextLabel
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self else { return }
                self.updateAvatar()
            }
        updateAvatar()
        
        view.backgroundColor = .ypBlackIOS
        
        addSubViews()
        addConstraints()
        
    }
    
    private func addSubViews() {
        view.addSubview(profileImageView)
        view.addSubview(userNameLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(userTextLabel)
        view.addSubview(buttonExit)
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            userEmailLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userTextLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            userTextLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 8),
            
            buttonExit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonExit.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    @objc
    private func didTapButton() {
        //TODO  - Добавить логику при нажатии на кнопку
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        
        // TODO [Sprint 11] Обновить аватар, используя Kingfisher
        
        print("error: updateAvatar")
        
        profileImageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "personPlaceholder.png")
            
        )
    }
}


