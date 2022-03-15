//
//  AppDelegate.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 06.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let viewController = GalleryPhotoViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = UIColor.black
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

