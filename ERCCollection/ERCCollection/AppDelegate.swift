//
//  AppDelegate.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initView()
        return true
    }
    
    func initView() {
        if window == nil {
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.backgroundColor = .white
            window?.rootViewController = UINavigationController(rootViewController: CollectionViewController())
            window?.makeKeyAndVisible()
        }
        if #available(iOS 14.0, *) {
            var bgConfig = UIBackgroundConfiguration.listPlainCell()
            bgConfig.backgroundColor = UIColor.white
            UITableViewHeaderFooterView.appearance().backgroundConfiguration = bgConfig
        }
        
    }


}

