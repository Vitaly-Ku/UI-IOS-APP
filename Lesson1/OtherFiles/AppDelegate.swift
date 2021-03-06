//
//  AppDelegate.swift
//  Lesson1
//
//  Created by Vit K on 22.03.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
//    func applicationDidFinishLaunching(_ application: UIApplication) {
//        if let realm = try? Realm() {
//            print(realm.configuration.fileURL, " файл Рилм")
//        }
//        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//        FirebaseApp.configure()
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let realm = try? Realm() {
            print(realm.configuration.fileURL, " файл Рилм")
        }
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        FirebaseApp.configure()
        
        return true
    }
}

