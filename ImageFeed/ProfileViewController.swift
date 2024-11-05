//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by sm on 31.10.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userPhoto = "Photo.png"
    let userNameText = "Екатерина Новикова"
    let userEmailText = "@ekaterina_nov"
    let userTextWords = "Hello, world!"
    let exitPictureName = "Exit.png"
    
    private lazy var buttonExit: UIButton = {
        let buttonExit = UIButton()
        buttonExit.setImage(UIImage(named: exitPictureName), for: .normal)
        buttonExit.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        buttonExit.translatesAutoresizingMaskIntoConstraints = false
        return buttonExit
    }()
    
    private lazy var profileImageView: UIImageView = {
        let profileImage = UIImage(named: userPhoto)
        let imageView = UIImageView(image: profileImage)
        imageView.tintColor = .gray
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
        
        addSubViews()
        addConstraints()
    }
    
    func addSubViews() {
        view.addSubview(profileImageView)
        view.addSubview(userNameLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(userTextLabel)
        view.addSubview(buttonExit)
    }
    
    func addConstraints() {

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            userEmailLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userTextLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            userTextLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 8),
            
            buttonExit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonExit.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    @objc
    private func didTapButton() {
        //TODO  - Добавить логику при нажатии на кнопку
    }
    
}


