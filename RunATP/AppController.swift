//
//  AppController.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-28.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Cocoa

class AppController: NSObject
{
    // Properties to hold the location (as a URL) of where the 'tpbigs' app is.
    var atpLocation:URL? = nil
    var tpbigLocation:URL?
    {
        set (newURL)
        {
            if let setURL = newURL
            {
                if FileManager.default.fileExists(atPath: setURL.path)
                {
                    self.atpLocation = setURL
                    
                    UserDefaults.standard.set(setURL, forKey: "ATP_URL")
                }
                else
                {
                    // leave the file as whatever it was and send an error message
                    DLog("Attempt to set nonexistant file for tpbigs!")
                }
            }
            else
            {
                // This really should not happen...
                DLog("Attemot to set nil to atpLocation!")
            }
        }
        
        get
        {
            return self.atpLocation
        }
    }
    
    // Menu handlers
    @IBAction func handleSetATPLocation(_ sender: Any)
    {
        let openPanel = NSOpenPanel()
        
        openPanel.message = "Please select the 'tpbigs' file."
        
    }
    
    
     

}
