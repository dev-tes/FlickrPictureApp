//
//  TabBarViewController.swift
//  FlickrPictureApp
//
//  Created by  Tes on 22/11/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .systemBlue
        setupVCs()
    }
    
    // MARK: - METHODS
    fileprivate func createNavController(for rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
           let navController = UINavigationController(rootViewController: rootViewController)
           navController.tabBarItem.image = image
          navController.tabBarItem.title = title
           navController.navigationBar.prefersLargeTitles = true
           return navController
       }
    func setupVCs() {
            viewControllers = [
                createNavController(for: PhotosViewController(), image: UIImage(systemName: "photo") ?? UIImage(), title: "Photos"),
                createNavController(for: FavouriteViewController(), image: UIImage(systemName: "star.circle") ?? UIImage(), title: "Favorite")
            ]
        }
    
}

