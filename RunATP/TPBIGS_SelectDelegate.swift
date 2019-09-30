//
//  TPBIGS_SelectDelegate.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-29.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Cocoa

class TPBIGS_SelectDelegate: NSObject, NSOpenSavePanelDelegate
{
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool
    {
        // Always enable directories so that the user can actually go into them
        if url.hasDirectoryPath
        {
            return true
        }
        
        // We only allow files called tpbigs
        if url.lastPathComponent == "tpbigs" || url.lastPathComponent == "tpbig" || url.lastPathComponent == "tpgigs" || url.lastPathComponent == "tpgig"
        {
            return true
        }
        
        return false
    }
 
}
