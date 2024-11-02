//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by sm on 02.11.2024.
//
import UIKit

class SingleImageViewController: UIViewController {
    
    var image: UIImage?{
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
