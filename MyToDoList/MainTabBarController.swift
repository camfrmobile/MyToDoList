//
//  MainTabBarController.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBar()
    }
    
    func setupTabBar() {
        let homeVC = ToDoListViewController()
        let navigationHome = UINavigationController(rootViewController: homeVC)
        navigationHome.tabBarItem = UITabBarItem(title: "To do list", image: UIImage(systemName: "checklist"), selectedImage: UIImage(systemName: "checklist.checked"))
        
        let noteVC = NoteViewController()
        noteVC.tabBarItem = UITabBarItem(title: "Note", image: UIImage(systemName: "note"), selectedImage: UIImage(systemName: "note.text"))
        
        self.viewControllers = [navigationHome, noteVC]
    }
}
