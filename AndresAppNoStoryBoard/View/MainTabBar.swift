//
//  ViewController.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 03/12/2021.
//
import UIKit

class MainTabBar: UITabBarController,UITabBarControllerDelegate {
    var appUser: [String:String]?
    let welcomeVC = UINavigationController(rootViewController: WelcomeView())
    let tracksTableVC = UINavigationController(rootViewController: TrackTableView())
    let playListDetailVC = UINavigationController(rootViewController: PlayListDetailView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabs()
        configureItemTabs()
        UITabBar.appearance().tintColor = UIColor(named: "TextColor")
        UITabBar.appearance().barTintColor = UIColor(named: "BackgroundColor")
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            self.navigationController?.title = viewController.title
            print("Should select viewController: \(viewController.title ?? "") ?")
            return true;
    }
    func configureTabs(){
        welcomeVC.navigationController?.navigationBar.prefersLargeTitles = true
        welcomeVC.navigationItem.largeTitleDisplayMode = .always
        welcomeVC.navigationBar.prefersLargeTitles = true
        welcomeVC.title = "Home"
        welcomeVC.navigationBar.topItem?.title = "Home"
       
        tracksTableVC.navigationController?.navigationBar.prefersLargeTitles = true
        tracksTableVC.navigationItem.largeTitleDisplayMode = .always
        tracksTableVC.navigationBar.prefersLargeTitles = true
        tracksTableVC.title = "Library"
        tracksTableVC.navigationBar.topItem?.title = "Library"
        
        playListDetailVC.navigationController?.navigationBar.prefersLargeTitles = true
        playListDetailVC.navigationItem.largeTitleDisplayMode = .always
        playListDetailVC.navigationBar.prefersLargeTitles = true
        playListDetailVC.title = "Playlist"
        playListDetailVC.navigationBar.topItem?.title = "Playlist"
    }
    func configureItemTabs(){
        let controllers = [welcomeVC,tracksTableVC,playListDetailVC]
        self.viewControllers = controllers
        
        guard let items = self.tabBar.items else { return }
        let images = ["house","music.note","music.note.list"]

        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}

