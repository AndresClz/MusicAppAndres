//
//  SceneDelegate.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 03/12/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var appUser: [String:String]? = [
        "name" : "Andres",
        "password" : "Password1234",
        "id" : "1"
    ]

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

//        let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = LoginView() // Your initial view controller.
//            window.makeKeyAndVisible()
//            self.window = window
        if(appUser != nil){
                let MainTBVC = MainTabBar()
                //let API = APIManager()
//                let callBack: ([Track]?, Error?) -> () = { canciones, error in
//                    if error != nil {
//                        print("no se encontraron las canciones")
//                    }
//                    else {
//                        misTracks = canciones ?? []
//                    }
//                }
            
                //API.getMusic(completion: callBack)
                MainTBVC.appUser = appUser
            
                RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in misTracks = [Track]()
                                if let _data = data {
                                    print("Traje los datos")
                                    misTracks = _data
                                }
                            }
            
                window.rootViewController = MainTBVC // Your initial view controller.
                window.makeKeyAndVisible()
                self.window = window
        } else {
                window.rootViewController = LoginView() // Your initial view controller.
                window.makeKeyAndVisible()
                self.window = window
        }
    }
    func setRootViewController(_ vc: UIViewController) {
//        let API = APIManager()
//        let callBack: ([Track]?, Error?) -> () = { canciones, error in
//            if error != nil {
//                print("no se encontraron las canciones")
//            }
//            else {
//                misTracks = canciones ?? []
//            }
//        }
//        API.getMusic(completion: callBack)
//
        RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in misTracks = [Track]()
                            if let _data = data {
                                misTracks = _data
                            }
                        }
         if let window = self.window {
              if let customTb = vc as? MainTabBar {
                   customTb.appUser = appUser
              }
              window.rootViewController = vc
                window.makeKeyAndVisible()
                 UIView.transition(with: window,
                                   duration: 0.3,
                                   options: .transitionCrossDissolve,
                                   animations: nil,
                                   completion: nil)
         }
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
    }


}

