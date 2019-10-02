//
//  AppController.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-28.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Foundation
import Cocoa

class AppController: NSObject, NSWindowDelegate
{
    var tpbigDirectory:URL? = nil
    
    @IBOutlet var atpFileView: NSTextView!
    
    // Set up some default stuff for our document window
    override func awakeFromNib()
    {
        if let startFontName = UserDefaults.standard.object(forKey: atpStartingFontNameKey) as? String
        {
            let startFontSize = UserDefaults.standard.double(forKey: atpStartingFontSizeKey)
            
            if let textFont = NSFont(name: startFontName, size: CGFloat(startFontSize))
            {
                self.atpFileView.font = textFont
            }
        }
        else
        {
            if let textFont = NSFont(name: "Menlo", size: 12.0)
            {
                self.atpFileView.font = textFont
            }
            else if #available(OSX 10.15, *)
            {
                self.atpFileView.font = NSFont.monospacedSystemFont(ofSize: 12.0, weight: .regular)
            }
            else if let textFont = NSFont(name: "Courier-New", size: 12.0)
            {
                self.atpFileView.font = textFont
            }
        }
        
        atpFileView.isHidden = false
    }
    
    
    
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
    
    @IBAction func hanldeOpenAtpFile(_ sender: Any)
    {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["dat", "txt"]
        
        if openPanel.runModal() == .OK
        {
            guard let theUrl = openPanel.url else
            {
                DLog("File System Error!!")
                return
            }
            
            var fileString = ""
            
            do
            {
                fileString = try String(contentsOf: theUrl)
                
                if !ValidateAtpFile(fileString: fileString)
                {
                    let alert = NSAlert()
                    alert.messageText = "This does not appear to be a valid ATP file. Do you still want to open it?"
                    alert.addButton(withTitle: "No")
                    alert.addButton(withTitle: "Yes, open it")
                    
                    if alert.runModal() == .alertFirstButtonReturn
                    {
                        return
                    }
                }
            }
            catch
            {
                let alert = NSAlert(error: error)
                let _ = alert.runModal()
                
                return
            }
            
            self.atpFileView.string = fileString
            self.atpFileView.needsDisplay = true
        }
        
    }
    
    func ValidateAtpFile(fileString:String) -> Bool
    {
        return fileString.contains("BEGIN NEW DATA CASE")
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
