//
//  AppController.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-28.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Foundation
import Cocoa

class AppController: NSObject, NSWindowDelegate, NSMenuItemValidation, NSTextViewDelegate
{
        
    // The directory where ATP (in the form of tpbigs) is located
    var tpbigDirectory:URL? = nil
    
    // The text view of the file currently in memory
    @IBOutlet var atpFileView: NSTextView!
    
    // The ATP file window
    @IBOutlet weak var atpFileWindow: NSWindow!
    
    // The current view's text has been edited
    var currentAtpTextIsDirty = false
    
    // The URL of the last-opened file
    var lastOpenedFile:URL? = nil
    
    // The window for the current LIS file
    @IBOutlet weak var lisFileWindow: NSWindow!
    
    // The text view for the last LIS file that was run
    @IBOutlet var lisFileView: NSTextView!
    
    // Set up some default stuff for our document window
    override func awakeFromNib()
    {
        if let startFontName = UserDefaults.standard.object(forKey: atpStartingFontNameKey) as? String
        {
            let startFontSize = UserDefaults.standard.double(forKey: atpStartingFontSizeKey)
            
            if let textFont = NSFont(name: startFontName, size: CGFloat(startFontSize))
            {
                self.atpFileView.font = textFont
                self.lisFileView.font = textFont
            }
        }
        else
        {
            if let textFont = NSFont(name: "Menlo", size: 12.0)
            {
                self.atpFileView.font = textFont
                self.lisFileView.font = textFont
            }
            else if #available(OSX 10.15, *)
            {
                self.atpFileView.font = NSFont.monospacedSystemFont(ofSize: 12.0, weight: .regular)
                self.lisFileView.font = NSFont.monospacedSystemFont(ofSize: 12.0, weight: .regular)
            }
            else if let textFont = NSFont(name: "Courier-New", size: 12.0)
            {
                self.atpFileView.font = textFont
                self.lisFileView.font = textFont
            }
        }
        
        self.atpFileView.delegate = self
        self.atpFileView.isHidden = false
        
    }
    
    // MARK: Menu item accessors
    @IBOutlet weak var fileSaveMenuItem: NSMenuItem!
    @IBOutlet weak var fileSaveAsMenuItem: NSMenuItem!
    @IBOutlet weak var fileRevertToSavedMenuItem: NSMenuItem!
    
    @IBOutlet weak var runAtpMenuItem: NSMenuItem!
    
    // Menu item validation
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool
    {
        if menuItem == self.fileSaveMenuItem
        {
            return self.currentAtpTextIsDirty
        }
        
        if menuItem == self.fileRevertToSavedMenuItem
        {
            return self.lastOpenedFile != nil && self.currentAtpTextIsDirty
        }
        
        if menuItem == self.fileSaveAsMenuItem
        {
            return self.lastOpenedFile != nil || self.currentAtpTextIsDirty
        }
        
        if menuItem == self.runAtpMenuItem
        {
            return self.lastOpenedFile != nil && self.tpbigDirectory != nil
        }
        
        return true
    }
    
    
    
    // MARK: Menu handlers
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
    
    @IBAction func handleOpenAtpFile(_ sender: Any)
    {
        // first we check if the current file (if any) is dirty and offer the user a chance to save
        if self.currentAtpTextIsDirty
        {
            let saveAlert = NSAlert()
            
            let fileName = self.lastOpenedFile == nil ? "untitled.dat" : self.atpFileWindow.title
            
            saveAlert.messageText = "Save changes to '\(fileName)' before closing?"
            saveAlert.informativeText = "If you don't save, your changes will be lost."
            
            saveAlert.addButton(withTitle: "Save")
            saveAlert.addButton(withTitle: "Cancel")
            saveAlert.addButton(withTitle: "Don't Save")
            
            let runResult = saveAlert.runModal()
            if runResult == .alertFirstButtonReturn
            {
                handleSaveAtpFile(sender)
            }
            else if runResult == .alertSecondButtonReturn
            {
                return
            }
        }
        
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
            
            self.atpFileWindow.title = theUrl.lastPathComponent
            self.atpFileWindow.makeKeyAndOrderFront(nil)
            self.lastOpenedFile = theUrl
            self.atpFileView.string = fileString
            self.atpFileView.needsDisplay = true
            NSDocumentController.shared.noteNewRecentDocumentURL(theUrl)
        }
        
    }
    
    @IBAction func handleCloseAtpFile(_ sender: Any)
    {
        if self.currentAtpTextIsDirty
        {
            let saveAlert = NSAlert()
            
            let fileName = self.lastOpenedFile == nil ? "untitled.dat" : self.atpFileWindow.title
            
            saveAlert.messageText = "Save changes to '\(fileName)' before closing?"
            saveAlert.informativeText = "If you don't save, your changes will be lost."
            
            saveAlert.addButton(withTitle: "Save")
            saveAlert.addButton(withTitle: "Cancel")
            saveAlert.addButton(withTitle: "Don't Save")
            
            let runResult = saveAlert.runModal()
            if runResult == .alertFirstButtonReturn
            {
                handleSaveAtpFile(sender)
            }
            else if runResult == .alertSecondButtonReturn
            {
                return
            }
            
            self.lastOpenedFile = nil
            self.currentAtpTextIsDirty = false
            self.atpFileView.string = ""
            self.atpFileView.needsDisplay = true
            self.atpFileWindow.title = "untitled.dat"
        }
    }
    
    
    @IBAction func handleSaveAtpFile(_ sender: Any)
    {
        guard let theUrl = self.lastOpenedFile else
        {
            DLog("The file hasn't been saved yet, doing 'Save As' instead")
            handleSaveAsAtpFile(sender)
            return
        }
        
        let fileMgr = FileManager.default
        let tempFileUrl = theUrl.deletingLastPathComponent().appendingPathComponent("new")
        
        do
        {
            try self.atpFileView.string.write(to: tempFileUrl, atomically: false, encoding: .utf8)
        }
        catch
        {
            let alert = NSAlert(error: error)
            let _ = alert.runModal()
            return
        }
        
        // make sure the original file still exists before deleting it
        if fileMgr.fileExists(atPath: theUrl.path)
        {
            do
            {
                try fileMgr.removeItem(at: theUrl)
                try fileMgr.moveItem(at: tempFileUrl, to: theUrl)
            }
            catch
            {
                let alert = NSAlert(error: error)
                let _ = alert.runModal()
                return
            }
        }
        
        // self.atpFileView.needsDisplay = true
        self.currentAtpTextIsDirty = false
    }
    
    @IBAction func handleSaveAsAtpFile(_ sender: Any)
    {
        let saveAsAlert = NSSavePanel()
        
        saveAsAlert.allowedFileTypes = ["dat"]
        
        if saveAsAlert.runModal() == .OK
        {
            let fileMgr = FileManager.default
            
            guard let theUrl = saveAsAlert.url else
            {
                DLog("The impossible has occurred")
                return
            }
            
            if fileMgr.fileExists(atPath: theUrl.path)
            {
                do
                {
                    try fileMgr.removeItem(at: theUrl)
                }
                catch
                {
                    let alert = NSAlert(error: error)
                    let _ = alert.runModal()
                    return
                }
            }
            
            do
            {
                try self.atpFileView.string.write(to: theUrl, atomically: false, encoding: .utf8)
            }
            catch
            {
                let alert = NSAlert(error: error)
                let _ = alert.runModal()
                return
            }
            
            self.atpFileWindow.title = theUrl.lastPathComponent
            self.lastOpenedFile = theUrl
            self.currentAtpTextIsDirty = false
            
            NSDocumentController.shared.noteNewRecentDocumentURL(theUrl)
            
        }
    }
    
    @IBAction func handleRevertToSavedAtpFile(_ sender: Any)
    {
        guard let theUrl = self.lastOpenedFile else
        {
            DLog("This should never happen")
            return
        }
        
        do
        {
            try self.atpFileView.string = String(contentsOf: theUrl)
        }
        catch
        {
            let alert = NSAlert(error: error)
            let _ = alert.runModal()
            return
        }
        
        self.atpFileView.needsDisplay = true
        self.currentAtpTextIsDirty = false
    }
    
    @IBAction func handleRunAtp(_ sender: Any)
    {
        if self.currentAtpTextIsDirty
        {
            let saveAlert = NSAlert()
            
            let fileName = self.lastOpenedFile == nil ? "untitled.dat" : self.atpFileWindow.title
            
            saveAlert.messageText = "Save changes to '\(fileName)' before running ATP?"
            saveAlert.informativeText = "If you don't save, your changes will be lost (and ATP will run with the last-saved version of the file)."
            
            saveAlert.addButton(withTitle: "Save")
            saveAlert.addButton(withTitle: "Cancel")
            saveAlert.addButton(withTitle: "Don't Save")
            
            let runResult = saveAlert.runModal()
            if runResult == .alertFirstButtonReturn
            {
                handleSaveAtpFile(sender)
            }
            else if runResult == .alertSecondButtonReturn
            {
                return
            }
        }
        
        guard let theUrl = self.lastOpenedFile else
        {
            DLog("This should never happen")
            return
        }
        
        guard let atpUrl = self.tpbigDirectory else
        {
            DLog("This should never happen")
            return
        }
        
        let tpbigs = TPBIGS(atpDirectory: atpUrl)
        
        // create our custom startup file, but only if it doesn't already exist in the directory
        let startupUrl = atpUrl.appendingPathComponent("pch_startup")
        
        if !FileManager.default.fileExists(atPath: startupUrl.path)
        {
            let startup = ATP_Startup()
            let newStartupString = startup.GenerateStartupFile()
            
            do
            {
                try newStartupString.write(to: startupUrl, atomically: false, encoding: .utf8)
            }
            catch
            {
                let alert = NSAlert(error: error)
                let _ = alert.runModal()
                return
            }
        }
        
        tpbigs.STARTUP = startupUrl
        
        do
        {
            try tpbigs.RunATP(inputURL: theUrl)
        }
        catch let error as TPBIGS.AtpRunError // The LIS file is either missing or has a "You lose, fella" condition
        {
            if error.type == .NoLisFile // missing file
            {
                let alert = NSAlert(error: error)
                let _ = alert.runModal()
            }
            else if error.type == .AtpError // "You lose, fella"
            {
                let alert = NSAlert()
                
                alert.messageText = "An error occured while running ATP\n\nKill Code: \(error.atpKillCode)\nOverlay: \(error.atpOverlay)\nNearby statement: \(error.atpNearbyStatementNumber)"
                
                alert.informativeText = error.atpErrorString
                
                let _ = alert.runModal()
            }
            
            return
        }
        catch // any other error that may be thrown
        {
            let alert = NSAlert(error: error)
            let _ = alert.runModal()
            
            return
        }
        
        // If we get here, we have a valid LIS file as well as a PL4 file available for reading.
        guard let lisUrl = tpbigs.LIS else
        {
            let alert = NSAlert()
            alert.messageText = "The LIS file does not exist!"
            let _ = alert.runModal()
            return
        }
        
        var lisString = ""
        
        do
        {
            try lisString = String(contentsOf: lisUrl)
        }
        catch
        {
            let alert = NSAlert(error: error)
            let _ = alert.runModal()
            return
        }
        
        self.lisFileView.string = lisString
        let filePrefix = theUrl.deletingPathExtension().lastPathComponent
        self.lisFileWindow.title = filePrefix + ".lis"
        
        
        guard let pl4Url = tpbigs.PL4 else
        {
            let alert = NSAlert()
            alert.messageText = "The PL4 file does not exist!"
            let _ = alert.runModal()
            return
        }
        
        let outputAlert = NSAlert()
        outputAlert.alertStyle = .informational
        outputAlert.messageText = "ATP has successfully completed execution. Do you wish to save the LIS and PL4 files?"
        outputAlert.informativeText = "Both files (.lis and .pl4) will be saved with the same name and location."
        
        outputAlert.addButton(withTitle: "Save")
        outputAlert.addButton(withTitle: "No")
        
        if outputAlert.runModal() == .alertSecondButtonReturn
        {
            return
        }
        
        let savePanel = NSSavePanel()
        savePanel.directoryURL = theUrl.deletingLastPathComponent()
        savePanel.allowedFileTypes = ["lis"]
        savePanel.nameFieldStringValue = filePrefix
        
        if savePanel.runModal() == .OK
        {
            guard let savedLisUrl = savePanel.url else
            {
                let alert = NSAlert()
                alert.messageText = "Could not get 'save' location."
                let _ = alert.runModal()
                return
            }
            
            let savedPl4Url = savedLisUrl.deletingPathExtension().appendingPathExtension("pl4")
            
            let fileMgr = FileManager.default
            
            do
            {
                try fileMgr.copyItem(at: lisUrl, to: savedLisUrl)
                try fileMgr.copyItem(at: pl4Url, to: savedPl4Url)
            }
            catch
            {
                let alert = NSAlert(error: error)
                let _ = alert.runModal()
                return
            }
            
            self.lisFileWindow.makeKeyAndOrderFront(nil)
            
        }
        
    }
    
    func ValidateAtpFile(fileString:String) -> Bool
    {
        // This is an extremely over-simplified way of checking whether the file is a valid ATP file but I get the feeling it is probably going to work most of the time.
        return fileString.contains("BEGIN NEW DATA CASE")
    }
    
    
    // MARK: Delegate functions
    
    // This is not strictly a delegate function for which AppController is the Delegate. It is called by AppDelegate if the user double-clicks a file for which our app is the "designated launcher". It is also used for the "Recent document" menu item
    func doAtpFileOpen(theUrl:URL) -> Bool
    {
        if self.currentAtpTextIsDirty
        {
            let saveAlert = NSAlert()
            
            let fileName = self.lastOpenedFile == nil ? "untitled.dat" : self.atpFileWindow.title
            
            saveAlert.messageText = "Save changes to '\(fileName)' before closing?"
            saveAlert.informativeText = "If you don't save, your changes will be lost."
            
            saveAlert.addButton(withTitle: "Save")
            saveAlert.addButton(withTitle: "Cancel")
            saveAlert.addButton(withTitle: "Don't Save")
            
            let runResult = saveAlert.runModal()
            if runResult == .alertFirstButtonReturn
            {
                handleSaveAtpFile(self)
            }
            else if runResult == .alertSecondButtonReturn
            {
                return false
            }
        }
        
        var fileString = ""
        
        do
        {
            fileString = try String(contentsOf: theUrl)
        }
        catch
        {
            let alert = NSAlert(error: error)
            let _ = alert.runModal()
            
            return false
        }
        
        self.atpFileWindow.title = theUrl.lastPathComponent
        self.atpFileWindow.makeKeyAndOrderFront(nil)
        self.lastOpenedFile = theUrl
        self.atpFileView.string = fileString
        self.atpFileView.needsDisplay = true
        
        NSDocumentController.shared.noteNewRecentDocumentURL(theUrl)
        
        return true
    }
    
    // This is not strictly a delegate function for which AppController is the Delegate. It is called by AppDelegate to make sure that unsaved changes can be saved when the user quits.
    func handleAppWillTerminate() -> Bool
    {
        if self.currentAtpTextIsDirty
        {
            let saveAlert = NSAlert()
            
            let fileName = self.lastOpenedFile == nil ? "untitled.dat" : self.atpFileWindow.title
            
            saveAlert.messageText = "Save changes to '\(fileName)' before closing?"
            saveAlert.informativeText = "If you don't save, your changes will be lost."
            
            saveAlert.addButton(withTitle: "Save")
            saveAlert.addButton(withTitle: "Cancel")
            saveAlert.addButton(withTitle: "Don't Save")
            
            let runResult = saveAlert.runModal()
            if runResult == .alertFirstButtonReturn
            {
                handleSaveAtpFile(self)
            }
            else if runResult == .alertSecondButtonReturn
            {
                return false
            }
            
            self.lastOpenedFile = nil
            self.currentAtpTextIsDirty = false
            self.atpFileView.string = ""
            self.atpFileView.needsDisplay = true
            self.atpFileWindow.title = "untitled.dat"
        }
        
        return true
    }
    
    func textDidChange(_ notification: Notification)
    {
        if notification.object as? NSTextView == self.atpFileView
        {
            self.currentAtpTextIsDirty = true
        }
    }
    
    
    
    // MARK: Debug Menu handlers
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
