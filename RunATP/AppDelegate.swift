//
//  AppDelegate.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-28.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

let atpUrlBookmarkKey = "PCH_ATP_URL_BOOKMARK"

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var appController: AppController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // initialize a Bool as if we have already saved a URL pointing to tpbigs
        var atpUrlWasSaved = true
    
        // check if we have a value saved in UserDefaults for the ATP URL
        if let bookmarkData = UserDefaults.standard.data(forKey: atpUrlBookmarkKey)
        {
            do
            {
                // we have a value, try to convert it to a URL
                var staleData:Bool = false
                let atpURL = try URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &staleData)
                
                if FileManager.default.fileExists(atPath: atpURL.path)
                {
                    appController.tpbigDirectory = atpURL
                }
                else
                {
                    atpUrlWasSaved = false
                }
            }
            catch
            {
                atpUrlWasSaved = false
            }
        }
        else
        {
            atpUrlWasSaved = false
        }
        
        if !atpUrlWasSaved
        {
            let alert = NSAlert()
            
            alert.alertStyle = .critical
            alert.messageText = "This program will only function if you have already installed a version of ATP on this machine. If you have ATP installed, then click 'Select ATP Folder'. If you have not yet installed ATP, then click Quit, download ATP, and install it before relaunching this program.\n\n"
            alert.addButton(withTitle: "Select ATP Folder")
            alert.addButton(withTitle: "Quit")
            
            if alert.runModal() == .alertFirstButtonReturn
            {
                appController.handleSetATPLocation(self)
            }
            else
            {
                NSApp.terminate(self)
            }
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

