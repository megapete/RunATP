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
        if url.lastPathComponent == "tpbigs"
        {
            do
            {
                // populate resSet with resource values that are in resSet (in this case, we're only interested in isExecutable)
                let resSet:Set<URLResourceKey> = [.isExecutableKey]
                let resVals = try url.resourceValues(forKeys:resSet)
                
                // The function may return nil, so we only test it if it's not nil
                if let isExec = resVals.isExecutable
                {
                    return isExec
                }
            }
            catch
            {
                return false
            }
            
            return false
        }
        
        return false
    }
}
