//
//  AppDelegate.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-28.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var appController: AppController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Insert code here to initialize your application
        if let atpLocation = UserDefaults.standard.object(forKey: "ATP_URL") as? URL
        {
            appController.tpbigLocation = atpLocation
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

