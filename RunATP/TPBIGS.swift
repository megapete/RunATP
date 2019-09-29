//
//  TPBIGS.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-29.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Cocoa

class TPBIGS: NSObject
{
    // The URL of the executable
    var atpExecutable:URL
    
    // The STARTUP file string to use when running ATP
    var STARTUP:String? = nil
    
    // Designated initializer. Note that no check is done to verify that the URL is actually the executable ATP file. This verification should be made prior to creating the TPBIGS object.
    init(atpExecutable:URL)
    {
        self.atpExecutable = atpExecutable
    }
    
    func RunATP(inputFileString:String, arguments:[String], STARTUP_FileString:String? = nil)
    {
        
    }
    
    func RunATP(inputURL:URL, arguments:[String], STARTUP_URL:URL)
    {
        
    }

}
