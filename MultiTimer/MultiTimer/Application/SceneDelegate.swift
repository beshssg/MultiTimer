//
//  SceneDelegate.swift
//  MultiTimer
//
//  Created by beshssg on 05.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window

        let navigationViewController = UINavigationController(rootViewController: ViewController())
        window.rootViewController = navigationViewController
    }


}

