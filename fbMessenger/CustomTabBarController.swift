//
//  CustomTabBarController.swift
//  fbMessenger
//
//  Created by Ice on 12/2/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import UIKit
class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup our custom viewController
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
        
        let calls = createDummyNavControllerWithTitle(title: "Calls", imageName: "calls")
        let groups = createDummyNavControllerWithTitle(title: "Groups", imageName: "groups")
        let peoples = createDummyNavControllerWithTitle(title: "Peoples", imageName: "people")
        let settings = createDummyNavControllerWithTitle(title: "Settings", imageName: "settings")
        
        viewControllers = [recentMessagesNavController, calls, groups, peoples, settings]
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }
    
}
