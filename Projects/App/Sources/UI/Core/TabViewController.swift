//
//  TabViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/05.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit
import DesignSystem

final class TabViewController: UITabBarController {
    private var selectedRectangleView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabs()
        addTopRectangleForSelectedTab()
        self.delegate = self
    }
    
    private func setupTabs() {
        let homeVC = HomeViewController()
        let shopVC = ShopViewController()
        let paidVC = PaidViewControlller()
        let hireVC = HireViewController()
        let myInfoVC = MyInfoViewController()
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: shopVC)
        let nav3 = UINavigationController(rootViewController: paidVC)
        let nav4 =  UINavigationController(rootViewController: hireVC)
        let nav5 = UINavigationController(rootViewController: myInfoVC)
        
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "매장", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "정산", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "채용", image: UIImage(systemName: "gear"), tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "MY", image: UIImage(systemName: "bell"), tag: 5)
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
    }
    
    private func addTopRectangleForSelectedTab() {
        selectedRectangleView.translatesAutoresizingMaskIntoConstraints = false
        selectedRectangleView.backgroundColor = .mainOwner
            
            guard let tabBarView = tabBar.selectedItem?.value(forKey: "view") as? UIView else { return }
            tabBarView.addSubview(selectedRectangleView)
            
            NSLayoutConstraint.activate([
                selectedRectangleView.topAnchor.constraint(equalTo: tabBarView.topAnchor),
                selectedRectangleView.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor),
                selectedRectangleView.widthAnchor.constraint(equalToConstant: 70),
                selectedRectangleView.heightAnchor.constraint(equalToConstant: 3)
            ])
    }
}

extension TabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let tabBarView = tabBar.selectedItem?.value(forKey: "view") as? UIView else { return }
        
        UIView.animate(withDuration: 0.25) {
            self.selectedRectangleView.removeFromSuperview()
            tabBarView.addSubview(self.selectedRectangleView)
            self.selectedRectangleView.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor).isActive = true
            self.view.layoutIfNeeded()
        }
    }
}
