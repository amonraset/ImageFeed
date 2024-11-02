//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by sm on 02.11.2024.
//
import UIKit

class SingleImageViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
