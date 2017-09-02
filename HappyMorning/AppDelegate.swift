//
//  AppDelegate.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/13/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit
import TwitterKit
import FacebookCore
import FacebookShare
import FacebookLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    // all cusomtizations performed globally on app after launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Twitter.sharedInstance().start(withConsumerKey:"DUnmzj5I5MbWlJm72N89FiVEz", consumerSecret:"cbM8fZBjAPb90hqb3AIrkRZIKyfkrml76kXGDdKEUv7lrjO3qg")
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
//        if UserDefaults.standard.bool(forKey: "loginPageViewed") {
//             UserDefaults.standard.setValue(false, forKey: "loginPageViewed")
//            self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC")
//        } else {
//            UserDefaults.standard.setValue(true, forKey: "loginPageViewed")
            self.window?.rootViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
//        }
    
        // Set navigation bar tint/background color (#7253A3)
        UINavigationBar.appearance().barTintColor = UIColor(red: 114.0/255, green: 83.0/255, blue: 163.0/255, alpha: 1.0)
        
        // Set font style and color of text, all titleTextAttributes need to be set in this array
        let navigationTitleFont = UIFont(name: "Avenir Next", size: 18)!
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navigationTitleFont, NSForegroundColorAttributeName: UIColor.white]
        
        // Set the tint color (back button when moving from one VC to another)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        // Change status bar color after setting it to NO in Info.plist
        UIApplication.shared.statusBarStyle = .lightContent
    
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let twitter =  Twitter.sharedInstance().application(app, open: url, options: options)
        let facebook = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        return twitter || facebook
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

