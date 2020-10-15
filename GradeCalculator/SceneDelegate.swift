//
//  SceneDelegate.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-30.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
//    }
    
    // initialize window manually as Main.storyboard is removed
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        let mainTBC = createTabBar(viewModel: GeneralViewModel()) // createSubjectListNC(rootVC: SubjectListVC())
        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UINavigationController(rootViewController: TestTableVC(style: .grouped)) //mainTBC // Your initial view controller.
        window.rootViewController = mainTBC
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func createTabBar(viewModel: GeneralViewModel) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            createSubjectListNC(viewModel: viewModel),
            createTermListNC(viewModel: viewModel),
            createHistoryListNC(viewModel: viewModel),
            createThirdNC()
        ]
        
        return tabBarController
    }
    
    func createSubjectListNC(viewModel: GeneralViewModel) -> UINavigationController {
        let tabBarItemTitle = NSLocalizedString("TAB_LABEL_CALCULATION", comment: "")
        let tabBarItemImage = UIImage(systemName: "pencil.and.ellipsis.rectangle")
        let tabBarItemTag = 0
        let subjectListVC = SubjectListVC(viewModel: viewModel)
        subjectListVC.tabBarItem = UITabBarItem(title: tabBarItemTitle, image: tabBarItemImage, tag: tabBarItemTag)
        let navController = UINavigationController(rootViewController: subjectListVC)
//        navController.navigationBar.backgroundColor = .white
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    func createTermListNC(viewModel: GeneralViewModel) -> UINavigationController {
        let tabBarItemTitle = NSLocalizedString("TAB_LABEL_TERMS", comment: "")
        let tabBarItemImage = UIImage(systemName: "folder")
        let tabBarItemTag = 1
        let termListVC = TermListVC(viewModel: viewModel)
        termListVC.tabBarItem = UITabBarItem(title: tabBarItemTitle, image: tabBarItemImage, tag: tabBarItemTag)
        let navController = UINavigationController(rootViewController: termListVC)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    func createHistoryListNC(viewModel: GeneralViewModel) -> UINavigationController {
        let tabBarItemTitle = NSLocalizedString("TAB_LABEL_HISTORY", comment: "")
        let tabBarItemImage = UIImage(systemName: "clock.fill")
        let tabBarItemTag = 2
        let historyListVC = HistoryListVC(viewModel: viewModel)
        historyListVC.tabBarItem = UITabBarItem(title: tabBarItemTitle, image: tabBarItemImage, tag: tabBarItemTag)
        let navController = UINavigationController(rootViewController: historyListVC)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    func createThirdNC() -> UINavigationController {
        let tabBarItemTitle = NSLocalizedString("TAB_LABEL_SETTING", comment: "")
        let tabBarItemImage = UIImage(systemName: "gear")
        let tabBarItemTag = 3
        let thirdVC = ThirdVC()
        thirdVC.title = "Third View Controller"
        thirdVC.tabBarItem = UITabBarItem(title: tabBarItemTitle, image: tabBarItemImage, tag: tabBarItemTag)
        
        return UINavigationController(rootViewController: thirdVC)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

