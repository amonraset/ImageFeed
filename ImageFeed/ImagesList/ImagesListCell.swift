//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by sm on 28.10.2024.
//

import UIKit


final class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier: String = "ImagesListCell"
    
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
}
