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
    var tpbigDirectory:URL? = nil
    
    // Menu handlers
    @IBAction func handleSetATPLocation(_ sender: Any)
    {
        let openPanel = NSOpenPanel()
        
        openPanel.message = "Please select one of the ATP programs (tpbig, tpbigs, tpgig, or tpgigs)."
        let opDelegate = TPBIGS_SelectDelegate()
        openPanel.delegate = opDelegate
        openPanel.prompt = "Select"
        
        if openPanel.runModal() == .OK
        {
            if let theURL = openPanel.directoryURL
            {
                do
                {
                    let bookmarkData = try theURL.bookmarkData()
                    
                    UserDefaults.standard.set(bookmarkData, forKey: atpUrlBookmarkKey)
                    
                    self.tpbigDirectory = theURL
                }
                catch
                {
                    DLog("Error while trying to set bookmark. The error is: \(error)")
                }
            }
        }
        
        DLog("Full path to ATP directory: \(self.tpbigDirectory!.path)")
        
    }
    
    // Debug Menu handlers
    @IBAction func handleResetAtpLocation(_ sender: Any)
    {
        UserDefaults.standard.removeObject(forKey: atpUrlBookmarkKey)
    }
    
    @IBAction func handleInputCigreDat(_ sender: Any)
    {
        if let url = self.tpbigDirectory
        {
            let fileURL = url.appendingPathComponent("cigre.dat")
            
            DLog("Checking for: \(fileURL.path)")
            
            do
            {
                let testString = try String(contentsOf: fileURL)
                
                DLog("Length of file is: \(testString.count)")
            }
            catch
            {
                DLog("Error while accessing cigre.dat. The error is \(error)")
            }
        }
    }
    
    @IBAction func handleGenerateStartup(_ sender: Any)
    {
        let startup = ATP_Startup()
        let newStartupString = startup.GenerateStartupFile()
        
        if let atpUrl = self.tpbigDirectory
        {
            let fileUrl = atpUrl.appendingPathComponent("pch_startup")
            
            do
            {
                try newStartupString.write(to: fileUrl, atomically: false, encoding: .utf8)
            }
            catch
            {
                DLog("An error occurred while writing STARTUP. The error was: \(error)")
            }
        }
    }
    
    @IBAction func handleTestTpbig(_ sender: Any)
    {
        let filePath = "/Users/peterhub/Local Docs/ATP_test/cigre.dat"
        
        let fileUrl = URL(fileURLWithPath: filePath)
        
        let atpObject = TPBIGS(atpDirectory: self.tpbigDirectory!)
        
        handleGenerateStartup(self)
        
        atpObject.STARTUP = self.tpbigDirectory!.appendingPathComponent("pch_startup")
        
        do
        {
            try atpObject.RunATP(inputURL: fileUrl)
        }
        catch
        {
            DLog("An error occured: \(error)")
        }
    }
    
    
}
