//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by sm on 15.01.2025.
//

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
}

final class ImagesListService {
    private (set) var photos: [Photo] = []
    
    private var lastLoadedPage: Int?
    
    // ...
    
    func fetchPhotosNextPage() {
        // ...
    }
}

func tableView(
  _ tableView: UITableView,
  willDisplay cell: UITableViewCell,
  forRowAt indexPath: IndexPath
) {
    // ...
}
