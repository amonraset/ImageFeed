//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by sm on 31.10.2024.
//

import UIKit

class ProfileViewController: UIViewController {
   
    
    @IBOutlet weak var UserPhoto: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet var UserEmail: UIView!
    @IBOutlet weak var UserText: UILabel!
    
    @IBOutlet weak var Exit: UIButton!
    
    @IBAction func Exit(_ sender: Any) {
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        }
}
