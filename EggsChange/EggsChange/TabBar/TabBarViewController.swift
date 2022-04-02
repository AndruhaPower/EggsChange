//
//  TabBarViewController.swift
//  EggsChange
//
//  Created by Андрей Жуков on 13.03.2022.
//

import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
    
    private enum TabType: Int {
        case main = 0
        case product
        case message
        case profile
    }
    
    private struct NestedController: Equatable {
        
        var type: TabType
        
        var viewController: UIViewController
        
        public static func == (lhs: NestedController, rhs: NestedController) -> Bool {
            return lhs.type == rhs.type
        }
    }
    
    private var nestedControllers: [NestedController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.delegate = self
        self.tabBar.standardAppearance.backgroundColor = .white
    }
    
    private func configure() {
        self.configureViewControllers()
        self.setNestedViewControllers()
    }
    
    private func configureViewControllers() {
        self.configureSwipeViewController()
        self.configureMessagesViewController()
        self.configureProductViewController()
        self.configureProfileViewController()
    }

    private func configureSwipeViewController() {
        let swipeViewController = SwipeViewController()
        let navigationController = InteractiveNavigationController(rootViewController: swipeViewController)
        let tabBarItem = UITabBarItem()
        
        tabBarItem.image = UIImage(systemName: "oval.portrait")
        tabBarItem.selectedImage = UIImage(systemName: "oval.portrait.fill")
        tabBarItem.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        
        swipeViewController.tabBarItem = tabBarItem
        self.nestedControllers.append(NestedController(type: .main, viewController: navigationController))
    }
    
    private func configureMessagesViewController() {
        let messagesViewController = MessagesViewController()
        let navigationController = InteractiveNavigationController(rootViewController: messagesViewController)
        let tabBarItem = UITabBarItem()
        
        tabBarItem.image = UIImage(systemName: "message")
        tabBarItem.selectedImage = UIImage(systemName: "message.fill")
        tabBarItem.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0)
        
        messagesViewController.tabBarItem = tabBarItem
        self.nestedControllers.append(NestedController(type: .message, viewController: navigationController))
    }
    
    private func configureProductViewController() {
        let productViewController = ProductViewController()
        let navigationController = InteractiveNavigationController(rootViewController: productViewController)
        let tabBarItem = UITabBarItem()
        
        tabBarItem.image = UIImage(systemName: "bag")
        tabBarItem.selectedImage = UIImage(systemName: "bag.fill")
        tabBarItem.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0)
        
        productViewController.tabBarItem = tabBarItem
        self.nestedControllers.append(NestedController(type: .product, viewController: navigationController))
    }
    
    private func configureProfileViewController() {
        let profileViewController = ProfileViewController()
        let navigationController = InteractiveNavigationController(rootViewController: profileViewController)
        let tabBarItem = UITabBarItem()
        
        tabBarItem.image = UIImage(systemName: "person.crop.circle")
        tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        tabBarItem.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0)
        
        profileViewController.tabBarItem = tabBarItem
        self.nestedControllers.append(NestedController(type: .profile, viewController: navigationController))
    }
    
    private func setNestedViewControllers() {
        let uniqueViewControllers = self.nestedControllers.removeDuplicates().map { $0.viewController }
        self.setViewControllers(uniqueViewControllers, animated: true)
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    
}
