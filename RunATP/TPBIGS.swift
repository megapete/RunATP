//
//  TPBIGS.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-29.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Foundation
import Cocoa

// Global values for to access the temporary input and output files. It is assumed that these files are actually stored in the user's temporary directory (as returned by FileManager)
let PCH_ATP_TEMPORARY_DIRECTORY = "PCH_ATP"
let PCH_ATP_TEMPORARY_FILE_PREFIX = "pch_run_atp"

struct ATP_Startup
{
    // The names of the members of this struct are the same as the names in the STARTUP file in the ATP Rulebook, except where noted
    // The default values are those given in the ATP Rulebook.
    
    // Card 1
    var RHIGH:Double = 1.0E10
    var EPSZNO:Double = 1.0E-8
    var EPWARN:Double = 1.0E-3
    var EPSTOP:Double = 0.1
    var EPSUBA:Double = 100.0
    var EPDGEL:Double = 1.0E-16
    var EPOMEG:Double = 1.0E-15
    var SZPLT:Double = 10.0
    var SZBED:Double = 72.0
    var TENFLZ:Double = 10.0 // TENFAC in Rulebook
    
    let Card1Names = "1  RHIGH  EPSZNO  EPWARN  EPSTOP  EPSUBA  EPDGEL  EPOMEG   SZPLT   SZBED  TENFLZ\n"
    
    
    // Card 2
    var SIGMAX:Double = 4.0 // from current STARTUP file
    var TENERG:Double = 1.0E20
    var DEGMIN:Double = 0.0
    var DEGMAX:Double = 360.0
    var ZNOMLIM_1:Double = 1.0 // Name in STARTUP: ZNOMLIM(1)
    var ZNOMLIM_2:Double = 1.5 // Name in STARTUP: (2)
    var STATFR:Double = 60.0
    var ZNVREF:Double = 1.0E-6
    var XMAXMX:Double = 2.0
    var AINCR:Double = 0.05
    
    let Card2Names = "2 SIGMAX  TENERG  DEGMIN  DEGMAX  ZNOLIM(1), (2)  STATFR  ZNVREF  XMAXMX   AINCR\n"
    
    // Card 3
    var FREQFR:Double = 0.0 // see Rulebook for why this field is set to 0
    var HLETT1:Double = 0.25
    var D4FACT:Double = -2.0 // Rulebook says unused
    var VHS:Double = 8.0
    var VS:Double = 1.0
    var VH:Double = 10.0
    var TAXISL:Double = 20.0
    var VAXISL:Double = 8.0
    var FILL1:Double = 6.0
    var FILL2:Double = 7.0
    
    let Card3Names = "3 FREQFR  HLETT1  D4FACT     VHS      VS      VH  TAXISL  VAXISL   FILL1   FILL2\n"
    
    // Card 4
    var TOLRCE:Double = 8.0E-5 // for some reason, this field is actually represented with an "E" instead of a "D"
    var FHTAX:Double = 0.5
    var FXSUP:Double = 0.25
    var FYSUP:Double = 0.03
    var FXTIT:Double = 0.1
    var FYTIT:Double = 0.1
    var VPLOTS:Double = 1.0
    var VPLOTL:Double = 5.0
    var FACTVI:Double = 0.0 // Rulebook says Unused
    var FTCARR:Double = 1.5
    
    let Card4Names = "4 TOLRCE   FHTAX   FXSUP   FYSUP   FXTIT   FYTIT  VPLOTS  VPLOTL  FACTVI  FTCARR\n"
    
    // Card 5
    var FXNUMV:Double = 1.5
    var FXNUMH:Double = 5.0
    var FVAXTT:Double = -1.5
    var FXVERT:Double = 0.0
    var UNIXON:Double = 0.0 // Rulebook says unused
    var TIMTAC:Double = 0.0
    var OVRLAP:Double = 0.5
    var FLZERO:Double = 1.0E-16
    var EPSILN:Double = 1.0E-8
    var FLTINF:Double = 1.0E16
    
    let Card5Names = "5 FXNUMV  FXNUMH  FVAXTT  FXVERT  UNIXON  TIMTAC  OVRLAP  FLZERO  EPSILN  FLTINF\n"
    
    // Card 6
    var XHEADM:Double = 2.5
    var YHEADM:Double = 7.95
    var HGTHDM:Double = 0.55
    var XCASTI:Double = 0.5
    var YCASTI:Double = 7.3
    var HGTCST:Double = 0.35
    var XLEGND:Double = 0.5
    var YLEGND:Double = 1.3
    var HGTLGN:Double = 0.25
    var TSTALL:Double = -0.0 // This is an integer called PIXPUN in the Rulebook
    
    let Card6Names = "6 XHEADM  YHEADM  HGTHDM  XCASTI  YCASTI  HGTCST  XLEGND  YLEGND  HGTLGN  TSTALL\n"
    
    // Card 7
    var XALPHA:Double = 1.5
    var YALPHA:Double = 6.5
    var HGTALF:Double = 0.25
    var D4FACT_2:Double = 1.0 // Redeclaration of same name (D4FACT) in the STARTUP file (differs from Rulebook)
    var PEKEXP:Double = 43.0
    var EPSLRT:Double = 1.0E-12
    var EPSPIV:Double = 1.0E-16
    var PLMARK:Double = 1.0
    var FACOSC:Double = 0.3
    
    let Card7Names = "7 XALPHA  YALPHA  HGTALF  D4FACT  PEKEXP  EPSLRT  EPSPIV  PLMARK  FACOSC  Unused\n"
    
    // Card 8
    var NMAUTO:Int = 1
    var INTINF:Int = 9999999
    var KOL132:Int = 132
    var MUNIT5:Int = 1
    var MAXZNO:Int = 50
    var IPRSPY:Int = -99
    var IPRSUP:Int = -99
    var LNPIN:Int = 1
    var MINHAR:Int = 0
    var MAXHAR:Int = 20
    
    let Card8Names = "8 NMAUTO  INTINF  KOL132  MUNIT5  MAXZNO  IPRSPY  IPRSUP   LNPIN  MINHAR  MAXHAR\n"
    
    // Card 9
    var NFORS2:Int = 30
    var NIOMAX:Int = 10
    var MRGN:Int = 2
    var LINLIM:Int = 100
    var MPAGE:Int = 0
    var MODE28:Int = 1
    var KPGRID:Int = 3
    var KPEN_1:Int = 12 // Name in STARTUP: KPEN(1)
    var KPEN_2:Int = 10 // Name in STARTUP: KPEN(2)
    var KPEN_3:Int = 11 // Name in STARTUP: KPEN(3)
    
    let Card9Names = "9 NFORS2  NIOMAX    MRGN  LINLIM   MPAGE  MODE28  KPGRID KPEN(1) KPEN(2) KPEN(3)\n"
    
    // Card 10
    var KPEN_4:Int = 14 // Name in STARTUP: ..(4)
    var KOMLEV:Int = -1
    var NSMTH:Int = 50
    var MODSCR:Int = 2
    var KOLALP:Int = 5
    var MAXFLG:Int = 1
    var LIMCRD:Int = 10000
    var NOBLAN:Int = 0
    var MOUSET:Int = 0
    var NOTPPL:Int = 1
    
    let Card10Names = "10 ..(4)  KOMLEV   NSMTH  MODSCR  KOLALP  MAXFLG  LIMCRD  NOBLAN  MOUSET  NOTPPL\n"
    
    // Card 11
    var NOCOMM:Int = 0
    var NOHELP:Int = 0
    var NEWPL4:Int = 0
    var JDELAY:Int = 0
    var NOTMAX:Int = 0 // Rulebook says "Unused"
    var NSMPLT:Int = 50
    var KOLWID:Int = 11
    var KOLSEP:Int = 1
    var JCOLU1:Int = 0
    var KSLOWR:Int = 25
    
    let Card11Names = "1 NOCOMM  NOHELP  NEWPL4  JDELAY  NOTMAX  NSMPLT  KOLWID  KOLSEP  JCOLU1  KSLOWR\n"
    
    // Card 12
    var KSYMBL:Int = 200
    var NOBACK:Int = 1
    var KOLEXM:Int = 60
    var LTEK:Int = 1
    var NCUT1:Int = 13
    var NCUT2:Int = 11
    var INCHPX:Int = 2
    var INCHPY:Int = 2
    var NODPCX:Int = 0
    var LCHLIM:Int = 0
    
    let Card12Names = "2 KSYMBL  NOBACK  KOLEXM    LTEK   NCUT1   NCUT2  INCHPX  INCHPY  NODPCX  LCHLIM\n"
    
    // Card 13
    var NORUN:Int = 0
    var JTURBO:Int = 5
    var MAXSYM:Int = 3
    var IHS:Int = 3
    var LIMCOL:Int = 79
    var KLEVL:Int = 0
    var KEXTR:Int = 0
    var NOHPGL:Int = 0
    var NOPOST:Int = 0
    var NOSM59:Int = 0
    
    let Card13Names = "13 NORUN  JTURBO  MAXSYM     IHS  LIMCOL   KLEVL   KEXTR  NOHPGL  NOPOST  NOSM59\n"
    
    // Card 14
    var LEFTA6:Int = 0 // IZGR2 in Rulebook
    var LENREC:Int = 0
    var LU6VRT:Int = 0 // actually, blank in STARTUP
    var LRLIM:Int = 75
    var KASEND:Int = 5
    var LUNDAT:Int = 3
    var KTRPL4:Int = -6666
    var JORIEN:Int = 0
    var LIMPNL:Int = 200
    var LUNTEX:Int = -11
    
    let Card14Names = "4 LEFTA6  LENREC  LU6VRT   LRLIM  KASEND  LUNDAT  KTRPL4  JORIEN  LIMPNL  LUNTEX\n"
    
    // Card 15
    var KINSEN:Int = 1
    var LISTON:Int = 0
    var LIMTAC:Int = 25
    var NOCALC:Int = 0
    var MFLUSH:Int = 1000
    var L4BYTE:Int = 0
    var KOMPAR:Int = 0
    var LIST01:Int = 0 // Does not exist in Rulebook
    var NOGNU:Int = 0 // Does not exist in Rulebook
    var KROSEC:Int = 0 // Does not exist in Rulebook
    
    let Card15Names = "5 KINSEN  LISTON  LIMTAC  NOCALC  MFLUSH  L4BYTE  KOMPAR  LIST01   NOGNU  KROSEC\n"
    
    // Card 16
    var LUNIT1:Int = 21
    var LUNIT2:Int = 22
    var LUNIT3:Int = 3
    var LUNIT4:Int = -4
    var LUNIT5:Int = 1
    var LUNIT6:Int = 6
    var LUNIT7:Int = 7
    var LUNIT8:Int = 8
    var LUNIT9:Int = 9
    var LUNT10:Int = 10
    
    let Card16Names = "6 LUNIT1  LUNIT2  LUNIT3  LUNIT4  LUNIT5  LUNIT6  LUNIT7  LUNIT8  LUNIT9  LUNT10\n"
    
    // Card 17
    var KS_1:Int = 0
    var KS_2:Int = 0
    var KS_3:Int = 12
    var KS_4:Int = 10
    var KP_1:Int = 7
    var KP_2:Int = 14
    var KP_3:Int = 0
    var KP_4:Int = 0
    var KOLROV:Int = 18
    var NUMHLD:Int = 0 // actually, blank in STARTUP
    
    let Card17Names = "17 KS(1)   KS(2)   KS(3)   KS(4)   KP(1)   KP(2)   KP(3)   KP(4)  KOLROV  NUMHLD\n"
    
    // Card 18-1 (STARTUP ONLY)
    var L4FULL:Int = 0
    var NOQUOT:Int = 0
    var JJEATS:Int = 0
    var NUMBUS:Int = -1
    var NOTAB:Int = 0
    var NOPISA:Int = 1
    var MSCSV:Int = 0
    var MAXL31:Int = 400
    var LIM132:Int = 0
    var MAXMVC:Int = 80
    
    let Card18_0Names = "8 L4FULL  NOQUOT  JJEATS  NUMBUS   NOTAB  NOPISA   MSCSV  MAXL31  LIM132  MAXMVC\n"
    
    // Card 18 (Rulebook and STARTUP)
    // Note that these variables & names come from the STARTUP file that comes with ATP as of Sept. 29, 2019 (the names and values differ somewhat from the Rulebook)
    var NameOfLanguageFontFile:String = "/blockd51.bin"
    var Window:String = "junk"
    var SpyFileName:String = "inclspy .dat"
    
    let Card18_1Names = "18 Name of language font file  ] Window] Root name for SPY @K usage    ]\n"
    
    // Card 19
    var SSONLY:String = "PHASOR"
    var CHEFLD:String = "E"
    var TEXNAM:String = "DUM"
    var CHVBAR:String = "|"
    var BRANCH:String = "NAME"
    var TXCOPY:String = "COPY"
    var USERID:String = "PCH" // I turned this into my abbreviaiton
    var TRASH:String = "......"
    var TERRA:String = "TERRA"
    var CHRCOM:String = "C {}$,"
    
    let Card19Names = "9 SSONLY  CHEFLD  TEXNAM  CHVBAR  BRANCH  TXCOPY  USERID  -TRASH  -TERRA  CHRCOM\n"
    
    // Card 20
    var DATTYP:String = ".dat"
    var LISTYP:String = ".lis"
    var PCHTYP:String = ".pch"
    var PL4TYP:String = ".pl4"
    var EFIELD:String = ""
    var FMTPL4:String = "wide10" // from a listserver thread answered by Orlando, to get text output for .pl4 file
    var PSCTYP:String = ".ps"
    // The next three vars come from the default STARTUP file
    var DBGTYP:String = ".dbg"
    var BINTYP:String = ".bin"
    var EXTTYP:String = ".ext"
    
    let Card20Names = "0 DATTYP  LISTYP  PCHTYP  PL4TYP  EFIELD  FMTPL4  PSCTYP  DBGTYP  BINTYP  EXTTYP\n"
    
    /*
    init(startupFile:URL)
    {
        // This function will initialize the ATP_Startup structure using the given file
    }
 */
    
    func GenerateStartupFile() -> String
    {
        // Generate a STARTUP file using the current values in the structure and return it as a string
        var startup = ""
        
        // Line 1
        startup += Card1Names
        // DLog("So far: \(startup)")
        let doublesFormat = "%8.3G%8.3G%8.3G%8.3G%8.3G%8.3G%8.3G%8.3G%8.3G%8.3G\n"
        let line1 = String(format: doublesFormat, RHIGH, EPSZNO, EPWARN, EPSTOP, EPSUBA, EPDGEL, EPOMEG, SZPLT, SZBED, TENFLZ)
        startup += line1
        
        // Line 2
        startup += Card2Names
        startup += String(format: doublesFormat, SIGMAX, TENERG, DEGMIN, DEGMAX, ZNOMLIM_1, ZNOMLIM_2, STATFR, ZNVREF, XMAXMX, AINCR)
        
        // Line 3
        startup += Card3Names
        startup += String(format: doublesFormat, FREQFR, HLETT1, D4FACT, VHS, VS, VH, TAXISL, VAXISL, FILL1, FILL2)
        
        // Line 4
        startup += Card4Names
        startup += String(format: doublesFormat, TOLRCE, FHTAX, FXSUP, FYSUP, FXTIT, FYTIT, VPLOTS, VPLOTL, FACTVI, FTCARR)
        
        // Line 5
        startup += Card5Names
        startup += String(format: doublesFormat, FXNUMV, FXNUMH, FVAXTT, FXVERT, UNIXON, TIMTAC, OVRLAP, FLZERO, EPSILN, FLTINF)
        
        // Line 6
        startup += Card6Names
        startup += String(format: doublesFormat, XHEADM, YHEADM, HGTHDM, XCASTI, YCASTI, HGTCST, XLEGND, YLEGND, HGTLGN, TSTALL)
        
        // Line 7
        startup += Card7Names
        startup += String(format: doublesFormat, XALPHA, YALPHA, HGTALF, D4FACT_2, PEKEXP, EPSLRT, EPSPIV, PLMARK, FACOSC, 0)
        
        // Line 8
        startup += Card8Names
        let integerFormat = "%8d%8d%8d%8d%8d%8d%8d%8d%8d%8d\n"
        startup += String(format: integerFormat, NMAUTO, INTINF, KOL132, MUNIT5, MAXZNO, IPRSPY, IPRSUP, LNPIN, MINHAR, MAXHAR)
        
        // Line 9
        startup += Card9Names
        startup += String(format:integerFormat, NFORS2, NIOMAX, MRGN, LINLIM, MPAGE, MODE28, KPGRID, KPEN_1, KPEN_2, KPEN_3)
        
        // Line 10
        startup += Card10Names
        startup += String(format:integerFormat, KPEN_4, KOMLEV, NSMTH, MODSCR, KOLALP, MAXFLG, LIMCRD, NOBLAN, MOUSET, NOTPPL)
        
        // Line 11
        startup += Card11Names
        startup += String(format:integerFormat, NOCOMM, NOHELP, NEWPL4, JDELAY, NOTMAX, NSMPLT, KOLWID, KOLSEP, JCOLU1, KSLOWR)
        
        // line 12
        startup += Card12Names
        startup += String(format:integerFormat, KSYMBL, NOBACK, KOLEXM, LTEK, NCUT1, NCUT2, INCHPX, INCHPY, NODPCX, LCHLIM)
        
        // Line 13
        startup += Card13Names
        startup += String(format:integerFormat, NORUN, JTURBO, MAXSYM, IHS, LIMCOL, KLEVL, KEXTR, NOHPGL, NOPOST, NOSM59)
        
        // Line 14
        startup += Card14Names
        startup += String(format:integerFormat, LEFTA6, LENREC, LU6VRT, LRLIM, KASEND, LUNDAT, KTRPL4, JORIEN, LIMPNL, LUNTEX)
        
        // Line 15
        startup += Card15Names
        startup += String(format:integerFormat, KINSEN, LISTON, LIMTAC, NOCALC, MFLUSH, L4BYTE, KOMPAR, LIST01, NOGNU, KROSEC)
        
        // Line 16
        startup += Card16Names
        startup += String(format:integerFormat, LUNIT1, LUNIT2, LUNIT3, LUNIT4, LUNIT5, LUNIT6, LUNIT7, LUNIT8, LUNIT9, LUNT10)
        
        // Line 17
        startup += Card17Names
        startup += String(format:integerFormat, KS_1, KS_2, KS_3, KS_4, KP_1, KP_2, KP_3, KP_4, KOLROV, NUMHLD)
        
        // Line 18(0)
        startup += Card18_0Names
        startup += String(format:integerFormat, L4FULL, NOQUOT, JJEATS, NUMBUS, NOTAB, NOPISA, MSCSV, MAXL31, LIM132, MAXMVC)
        
        // Line 18(1) (The lastfew lines are gross because we can't set the length of a Swift String in 'format')
        startup += Card18_1Names
        var numSpaces = 33 - NameOfLanguageFontFile.count
        var spaceString = String(repeating: " ", count: numSpaces)
        startup += NameOfLanguageFontFile + spaceString
        
        numSpaces = 8 - Window.count
        spaceString = String(repeating: " ", count: numSpaces)
        startup += Window + spaceString
        startup += SpyFileName + "\n"
        
        // Line 19
        startup += Card19Names
        
        startup += "  " + LeftJustifyString(wString: SSONLY, width: 8)
        startup += LeftJustifyString(wString: CHEFLD, width: 8)
        startup += LeftJustifyString(wString: TEXNAM, width: 8)
        startup += LeftJustifyString(wString: CHVBAR, width: 8)
        startup += LeftJustifyString(wString: BRANCH, width: 8)
        startup += LeftJustifyString(wString: TXCOPY, width: 8)
        startup += LeftJustifyString(wString: USERID, width: 8)
        startup += LeftJustifyString(wString: TRASH, width: 8)
        startup += LeftJustifyString(wString: TERRA, width: 8)
        startup += LeftJustifyString(wString: CHRCOM, width: 6)
        startup += "\n"
        
        // Line 20
        startup += Card20Names
        
        startup += "  " + LeftJustifyString(wString: DATTYP, width: 8)
        startup += LeftJustifyString(wString: LISTYP, width: 8)
        startup += LeftJustifyString(wString: PCHTYP, width: 8)
        startup += LeftJustifyString(wString: PL4TYP, width: 8)
        startup += LeftJustifyString(wString: EFIELD, width: 8)
        startup += LeftJustifyString(wString: FMTPL4, width: 8)
        startup += LeftJustifyString(wString: PSCTYP, width: 8)
        startup += LeftJustifyString(wString: DBGTYP, width: 8)
        startup += LeftJustifyString(wString: BINTYP, width: 8)
        startup += LeftJustifyString(wString: EXTTYP, width: 6)
        startup += "\n"
        
        return startup
    }
    
    func LeftJustifyString(wString:String, width:Int) -> String
    {
        let numSpaces = width - wString.count
        
        if numSpaces <= 0
        {
            return wString
        }
        
        return wString + String(repeating: " ", count: numSpaces)
    }
}

class TPBIGS: NSObject
{
    // The URL of the executable
    var atpDirectory:URL
    
    // The STARTUP file string to use when running ATP. If this is nil, it is assumed that the file STARTUP that is located in the same directory as TPBIGS will be used.
    var STARTUP:URL? = nil
    
    // Output files from ATP.
    var LIS:URL?
    var PL4:URL?
    
    // Designated initializer. Note that no check is done to verify that the URL is actually the ATP folder. This verification should be made prior to creating the TPBIGS object.
    init(atpDirectory:URL)
    {
        self.atpDirectory = atpDirectory
        self.LIS = nil
        self.PL4 = nil
    }
    
    enum RunAtpError: Error
    {
        case AtpError(errorLine:String)
        case NoStartupFileError
        case NoGraphicsFileError
        case NoGraphicsAuxFileError
        case AtpCouldNotRunError(errorLine:String)
        
        case IllegalDataFile
        case FileSystemError
        case TaskRunError
    }
    
    
    func RunATP(inputURL:URL, arguments:[String] = [], STARTUP_URL:URL? = nil) throws
    {
        // we'll need this a few times
        let defFileMgr = FileManager.default
        
        // check if there was a new STARTUP file passed to the function
        var useStartupURL = STARTUP_URL
        
        // nope, check if we have a valid STARTUP URL attached to self
        if useStartupURL == nil
        {
            useStartupURL = self.STARTUP
        }
        
        // we'll use this flag later to reset the name of any existing STARTUP file that we changed
        var replacedStartup = false
        
        if useStartupURL != nil
        {
            // we're using our own version of STARTUP, so change the name of the old one (if it exists, and it's not the one we're using)
            let startupURL = self.atpDirectory.appendingPathComponent("startup")
            
            // make sure the user didn't simply send in the STARTUP file that's already in the ATP folder
            if startupURL != useStartupURL!
            {
                // confirm that the file actually exists
                if defFileMgr.fileExists(atPath: startupURL.path)
                {
                    do
                    {
                        // add the extension "old" to the existing startup file
                        try defFileMgr.moveItem(at: startupURL, to: startupURL.appendingPathExtension("old"))
                        
                        // copy the custom STARTUP over to the ATP folder with the name STARTUP
                        try defFileMgr.copyItem(at: useStartupURL!, to: startupURL)
                        
                        // flag so that we can rename the old file at the end
                        replacedStartup = true
                    }
                    catch
                    {
                        // DLog("There was a problem replacing STARTUP. The error was: \(error)")
                        throw(error)
                    }
                }
                else
                {
                    do
                    {
                        // copy the custom STARTUP over to the ATP folder with the name STARTUP
                        try defFileMgr.copyItem(at: useStartupURL!, to: startupURL)
                    }
                    catch
                    {
                        // DLog("There was a problem creating STARTUP. The error was: \(error)")
                        throw(error)
                    }
                }
            }
        }
        
        // We'll actually always run a temporary file called "pch_run_atp.dat", regardless of the file passed to this routine. We access a folder called "PCH_ATP" which is in the user's temporary directory (we create the directory if it does not yet exist) and put the file in there. The calling routine is responsible for the following:
        
        //  1) Making reasonably sure that the file is a valid ATP file
        //  2) Saving the resulting output files, all of which will have the prefix "pch_run_atp" and be located in the temporary folder.
        
        // Get the temporary directory for the current user
        let tmpDir = defFileMgr.temporaryDirectory.appendingPathComponent(PCH_ATP_TEMPORARY_DIRECTORY, isDirectory: true)
        if !defFileMgr.fileExists(atPath: tmpDir.path)
        {
            do
            {
                try defFileMgr.createDirectory(at: tmpDir, withIntermediateDirectories: true, attributes: nil)
            }
            catch
            {
                // DLog("Could not create temporary directory. The error was: \(error)")
                throw(error)
            }
        }
        
        let tmpInputUrl = tmpDir.appendingPathComponent(PCH_ATP_TEMPORARY_FILE_PREFIX + ".dat")
        
        if defFileMgr.fileExists(atPath: tmpInputUrl.path)
        {
            do
            {
                try defFileMgr.removeItem(at: tmpInputUrl)
            }
            catch
            {
                // DLog("Could not remove existing input file. The error was: \(error)")
                throw(error)
            }
        }
        
        // copy the input file over to the temporary file
        do
        {
            try defFileMgr.copyItem(at: inputURL, to: tmpInputUrl)
        }
        catch
        {
            // DLog("Could not copy the input file. The error was: \(error)")
            throw(error)
        }
        
        // run tpbigs
        let atpTask = Process()
        atpTask.currentDirectoryURL = self.atpDirectory
        atpTask.executableURL = self.atpDirectory.appendingPathComponent("tpbigs")
        atpTask.arguments = ["DISK", tmpInputUrl.path, "s", "-r"]
        
        do
        {
            try atpTask.run()
            atpTask.waitUntilExit()
        }
        catch
        {
            // DLog("Error while running ATP task: The error was: \(error)")
            throw(error)
        }
        
        // check if we used a custom STARTUP and if so, fix the old one so everything is okay again
        if replacedStartup
        {
            do
            {
                let startupURL = self.atpDirectory.appendingPathComponent("startup")
                let oldStartupURL = self.atpDirectory.appendingPathComponent("startup.old")
                
                try defFileMgr.removeItem(at: startupURL)
                try defFileMgr.moveItem(at: oldStartupURL, to: startupURL)
            }
            catch
            {
                // DLog("An error occurred: \(error)")
                throw(error)
            }
        }
        
        let lisUrl = tmpDir.appendingPathComponent(PCH_ATP_TEMPORARY_FILE_PREFIX + ".lis")
        
        do
        {
            try CheckLisFileForError(lisFile: lisUrl)
        }
        catch
        {
            throw(error)
        }
        
        
    }
    
    struct AtpRunError:Error
    {
        enum errorType
        {
            case NoLisFile // no LIS file was created (not sure that this can happen)
            case AtpError // "You lose, fella"
        }
        
        let atpLastLine:String
        let atpKillCode:Int
        let atpOverlay:Int
        let atpNearbyStatementNumber:Int
        let atpErrorString:String
        let type:errorType
        
        var localizedDescription: String
        {
            get
            {
                if self.type == .NoLisFile
                {
                    return "ATP Runtime Error: No ouput (LIS) file was created."
                }
                else if self.type == .AtpError
                {
                    return "ATP Runtime Error: The last read line was \(atpLastLine) with KILL CODE = \(atpKillCode)"
                }
                else
                {
                    return "No error"
                }
            }
        }
    }
    
    func CheckLisFileForError(lisFile:URL) throws
    {
        if !FileManager.default.fileExists(atPath: lisFile.path)
        {
            let error = AtpRunError(atpLastLine: "", atpKillCode: 0, atpOverlay: 0, atpNearbyStatementNumber: 0, atpErrorString: "", type: .NoLisFile)
            
            throw(error)
        }
        
        var lisFileString = ""
        
        do
        {
            lisFileString = try String(contentsOf: lisFile)
        }
        catch
        {
            throw(error)
        }
        
        if lisFileString.contains("ERROR/ERROR/ERROR")
        {
            var lisLines = lisFileString.components(separatedBy: .newlines)
            
            while !lisLines[0].contains("ERROR/ERROR/ERROR")
            {
                lisLines.remove(at: 0)
            }
            
            // remove 8 more lines
            for _ in 0..<8
            {
                lisLines.remove(at: 0)
            }
            
            let lastLine = lisLines[0]
            
            // remove two lines
            lisLines.remove(at: 0)
            lisLines.remove(at: 0)
            
            // next line has Kill code, Overlay number, and Nearby statement line, separated by spaces
            let killLine = lisLines[0].components(separatedBy: .whitespaces).filter{$0 != ""}
            
            let killCode = Int(killLine[0])!
            let overlay = Int(killLine[1])!
            let nearbyLine = Int(killLine[2])!
            
            lisLines.remove(at: 0)
            
            var errorString = ""
            while !lisLines[0].contains("---------------")
            {
                errorString += lisLines[0] + " "
                lisLines.remove(at: 0)
            }
            
            let error = AtpRunError(atpLastLine: lastLine, atpKillCode: killCode, atpOverlay: overlay, atpNearbyStatementNumber: nearbyLine, atpErrorString: errorString, type: .AtpError)
            
            throw(error)
            
        }
        
        
    }

}
