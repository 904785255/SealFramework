//
//  SceneDelegate.swift
//  OnePartner
//
//  Created by bin sun on 2025/7/2.
//

import Foundation
import UIKit
var shortcutItemToProcess: UIApplicationShortcutItem?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        print("SceneDelegate-willConnectTo")
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let shortcutItem = connectionOptions.shortcutItem else { return }

        shortcutItemToProcess = shortcutItem
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("SceneDelegate-performActionFor")
        shortcutItemToProcess = shortcutItem

        handleShortcutItem(shortcutItem, completionHandler: completionHandler)
    }
    private func handleShortcutItem(
        _ shortcutItem: UIApplicationShortcutItem,
        completionHandler: ((Bool) -> Void)? = nil
    ) {
        print("App shortcutItem: -> \(shortcutItem)")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
   
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

