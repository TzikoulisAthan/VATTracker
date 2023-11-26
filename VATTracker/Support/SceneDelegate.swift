//
//  SceneDelegate.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 7/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
    }
    
    func createMainNC() -> UINavigationController {
        let mainVC = MainVC()
        mainVC.title = "Overview"
        mainVC.tabBarItem.image = UIImage(systemName: "dollarsign.square")
        
        return UINavigationController(rootViewController: mainVC)
    }
    
    func createNewInvoiceVC() -> UINavigationController {
        let invoiceVC = NewInvoiceVC()
        invoiceVC.title = "Add Invoice"
        invoiceVC.tabBarItem.image = UIImage(systemName: "plus.circle")
        
        return UINavigationController(rootViewController: invoiceVC)
    }
    
    
    func createInvoiceListVC() -> UINavigationController {
        let invoiceListVC = InvoiceListVC()
        invoiceListVC.title = "Invoices"
        invoiceListVC.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        
        return UINavigationController(rootViewController: invoiceListVC)
    }
    
    func createTabbar() -> UITabBarController {
        let tabbar = CustomTabbarController()
        UITabBar.appearance().tintColor = UIColor(displayP3Red: 0, green: 0.498, blue: 0.8588, alpha: 1.0)
        tabbar.viewControllers = [createMainNC(), createNewInvoiceVC(), createInvoiceListVC()]
      
        
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

