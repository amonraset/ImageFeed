//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by sm on 28.10.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let reuseIdentifier: String = "ImagesListCell"
    
    // MARK: - @IBOutlet properties
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
}
