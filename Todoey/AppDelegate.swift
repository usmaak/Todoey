//
//  AppDelegate.swift
//  Todoey
//
//  Created by Scott Kilbourn on 6/27/18.
//  Copyright © 2018 Scott Kilbourn. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(
            
            schemaVersion: 1,
            
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < 1) {
                    
                    migration.enumerateObjects(ofType: Category.className()) { (old, new) in
                        new!["dateCreated"] = Date()
                    }
                    migration.enumerateObjects(ofType: Item.className()) { (old, new) in
                        new!["dateCreated"] = Date()
                    }
                }
        })
        
        Realm.Configuration.defaultConfiguration = config

        do {
            _ = try Realm()
        }
        catch {
            print ("Error initializing new Realm \(error)")
        }
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        return true
    }

}

