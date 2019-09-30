//
//  TPBIGS.swift
//  RunATP
//
//  Created by Peter Huber on 2019-09-29.
//  Copyright © 2019 Peter Huber. All rights reserved.
//

import Cocoa

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
    var TENFAC:Double = 10.0
    
    let Card1Names:[String] = ["RHIGH","EPSZNO","EPWARN","EPSTOP","EPSUBA","EPDGEL","EPOMEG","SZPLT","SZBED","TENFAC"]
    
    // Card 2
    var SIGMAX:Double = 2.0
    var TENERG:Double = 1.0E20
    var DEGMIN:Double = 0.0
    var DEGMAX:Double = 360.0
    var ZNOMLIM_1:Double = 1.0 // Name in STARTUP: ZNOMLIM(1)
    var ZNOMLIM_2:Double = 1.5 // Name in STARTUP: (2)
    var STATFR:Double = 60.0
    var ZNVREF:Double = 1.0E-6
    var XMAXMX:Double = 2.0
    var AINCR:Double = 0.05
    
    let Card2Names:[String] = ["SIGMAX","TENERG","DEGMIN","DEGMAX","ZNOMLIM(1)","(2)","STATFR","ZNVREF","XMAXMX","AINCR"]
    
    // Card 3
    var FREQFR:Double = 0.0 // see Rulebook for why this field is set to 0
    var HLETT1:Double = 0.25
    // Unused
    var VHS:Double = 8.0
    var VS:Double = 1.0
    var VH:Double = 10.0
    var TAXISL:Double = 10.0
    var VAXISL:Double = 8.0
    var FILL1:Double = 6.0
    var FILL2:Double = 7.0
    
    let Card3Names:[String] = ["FREQFR","HLETT1","Unused","VHS","VS","VH","TAXISL","VAXISL","FILL1","FILL2"]
    
    // Card 4
    var TOLRCE:Double = 8.0E-5
    var FHTAX:Double = 0.5
    var FXSUP:Double = 0.25
    var FYSUP:Double = 0.03
    var FXTIT:Double = 0.1
    var FYTIT:Double = 0.1
    var VPLOTS:Double = 1.0
    var VPLOTL:Double = 5.0
    // Unused
    var FTCARR:Double = 1.5
    
    let Card4Names:[String] = ["TOLRCE","FHTAX","FXSUP","FYSUP","FXTIT","FYTIT","VPLOTS","VPLOTL","Unused","FTCARR"]
    
    // Card 5
    var FXNUMV:Double = 1.5
    var FXNUMH:Double = 5.0
    var FVAXTT:Double = -2.5
    var FXVERT:Double = 0.0
    // Unused
    var TIMTAC:Double = 0.0
    var OVRLAP:Double = 0.5
    var FLZERO:Double = 1.0E-12
    var EPSILN:Double = 1.0E-8
    var FLTINF:Double = 1.0E19
    
    let Card5Names:[String] = ["FXNUMV","FXNUMH","FVAXTT","FXVERT","Unused","TIMTAC","OVRLAP","FLZERO","EPSILN","FLTINF"]
    
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
    var PIXPUN:Int = 40
    
    let Card6Names:[String] = ["XHEADM","YHEADM","HGTHDM","XCASTI","YCASTI","HGTCST","XLEGND","YLEGND","HGTLGN","PIXPUN"]
    
    // Card 7
    var XALPHA:Double = 1.5
    var YALPHA:Double = 6.5
    var HGTALF:Double = 0.25
    var D4FACT:Double = -2.0
    var PEKEXP:Double = 43.0
    var EPSLRT:Double = 1.0E-12
    var EPSPIV:Double = 1.0E-16
    var PLMARK:Double = 1.0
    var FACOSC:Double = 0.3
    
    let Card7Names:[String] = ["XALPHA","YALPHA","HGTALF","D4FACT","PEKEXP","EPSLRT","EPSPIV","PLMARK","FACOSC",""]
    
    // Card 8
    var NMAUTO:Int = 1
    var INTINF:Int = 9999999
    var KOL132:Int = 132
    var MUNIT5:Int = 1
    var MAXZNO:Int = 50
    var IPRSPY:Int = 0
    var IPRSUP:Int = 0
    var LNPIN:Int = 6
    var MINHAR:Int = 0
    var MAXHAR:Int = 20
    
    let Card8Names:[String] = ["NMAUTO","INTINF","KOL132","MUNIT5","MAXZNO","IPRSPY","IPRSUP","LNPIN","MINHAR","MAXHAR"]
    
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
    
    let Card9Names:[String] = ["NFORS2","NIOMAX","MRGN","LINLIM","MPAGE","MODE28","KPGRID","KPEN(1)","KPEN(2)","KPEN(3)"]
    
    // Card 10
    var KPEN_4:Int = 14 // Name in STARTUP: ..(4)
    var KOMLEV:Int = -1
    var NSMTH:Int = 50
    var MODSCR:Int = 2
    var KOLALP:Int = 5
    var MAXFLG:Int = 1
    var LIMCRD:Int = 3000
    var NOBLAN:Int = 1
    var MOUSET:Int = 0
    var NOTPPL:Int = 1
    
    let Card10Names:[String] = ["..(4)","KOMLEV","NSMTH","MODSCR","KOLALP","MAXFLG","LIMCRD","NOBLAN","MOUSET","NOTPPL"]
    
    // Card 11
    var NOCOMM:Int = 0
    var NOHELP:Int = 0
    var NEWPL4:Int = 0
    var JDELAY:Int = 0
    // Unused
    var NSMPLT:Int = 50
    var KOLWID:Int = 11
    var KOLSEP:Int = 1
    var JCOLU1:Int = 0
    var KSLOWR:Int = 5
    
    let Card11Names:[String] = ["NOCOMM","NOHELP","NEWPL4","JDELAY","Unused","NSMPLT","KOLWID","KOLSEP","JCOLU1","KSLOWR"]
    
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
    
    let Card12Names:[String] = ["KSYMBL","NOBACK","KOLEXM","LTEK","NCUT1","NCUT2","INCHPX","INCHPY","NODPCX","LCHLIM"]
    
    // Card 13
    var NORUN:Int = 0
    var JTURBO:Int = 1
    var MAXSYM:Int = 3
    var IHS:Int = 3
    var LIMCOL:Int = 79
    var KLEVL:Int = 0
    var KEXTR:Int = 0
    var NOHPGL:Int = 0
    var NOPOST:Int = 0
    var IZGR1:Int = 2
    
    let Card13Names:[String] = ["NORUN","JTURBO","MAXSYM","IHS","LIMCOL","KLEVL","KEXTR","NOHPGL","NOPOST","IZGR1"]
    
    // Card 14
    var IZGR2:Int = 0
    var LENREC:Int = 0
    var LU6VRT:Int = 32768
    var LRLIM:Int = 75
    var KASEND:Int = 5
    var LUNDAT:Int = 3
    var KTRPL4:Int = -4
    var JORIEN:Int = 0
    var LIMPNL:Int = 200
    var LUNTEX:Int = -11
    
    let Card14Names:[String] = ["IZGR2","LENREC","LU6VRT","LRLIM","KASEND","LUNDAT","KTRPL4","JORIEN","LIMPNL","LUNTEX"]
    
    // Card 15
    var KINSEN:Int = 1
    var LISTON:Int = 0
    var LIMTAC:Int = 25
    var NOCALC:Int = 0
    var MFLUSH:Int = 1000
    var L4BYTE:Int = 1
    var KOMPAR:Int = 0
    
    let Card15Names:[String] = ["KINSEN","LISTON","LIMTAC","NOCALC","MFLUSH","L4BYTE","KOMPAR","","",""]
    
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
    
    let Card16Names:[String] = ["LUNIT1","LUNIT2","LUNIT3","LUNIT4","LUNIT5","LUNIT6","LUNIT7","LUNIT8","LUNIT9","LUNT10"]
    
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
    
    let Card17Names:[String] = ["KS(1)","KS(2)","KS(3)","KS(4)","KP(1)","KP(2)","KP(3)","KP(4)","KOLROV","Unused"]
    
    // Card 18
    // Note that these variables & names come from the STARTUP file that comes with ATP as of Sept. 29, 2019 (the names and values differ somewhat from the Rulebook)
    var NameOfLanguageFontFile:String = "/blockd51.bin"
    var Window:String = "junk"
    var SpyFileName:String = "inclspy .dat"
    
    let Card18Names:[String] = ["Name of language font file  ] ","Window] ","Root name for SPY @K usage    ]"]
    
    // Card 19
    var SSONLY:String = "PHASOR"
    var CHEFLD:String = "E"
    var TEXNAM:String = "DUM"
    var CHVBAR:String = "|"
    var BRANCH:String = "NAME"
    var TXCOPY:String = "COPY"
    var USERID:String = "Hannov" // This comes from the default STARTUP file, which differs from the Rulebook
    var TRASH:String = "......"
    var TERRA:String = "TERRA"
    var CHRCOM:String = "C {}$,"
    
    let Card19Names:[String] = ["SSONLY","CHEFLD","TEXNAM","CHVBAR","BRANCH","TXCOPY","USERID","-TRASH","-TERRA","CHRCOM"]
    
    // Card 20
    var DATTYP:String = ".dat"
    var LISTYP:String = "lis"
    var PCHTYP:String = "pch"
    var PL4TYP:String = "pl4"
    var EFIELD:String = ""
    var FMTPL4:String = "10E8.0"
    var PSCTYP:String = ".ps"
    // The next three vars come from the default STARTUP file
    var DBGTYP:String = "dbg"
    var BINTYP:String = ".bin"
    var EXTTYP:String = ".ext"
    
    let Card20Names:[String] = ["DATTYP","LISTYP","PCHTYP","PL4TYP","EFIELD","FMTPL4","PSCTYP","DBGTYP","BINTYP","EXTTYP"]
    
    init(startupFile:URL)
    {
        // This function will initialize the ATP_Startup structure using the given file
    }
    
    func GenerateStartupFile() -> String
    {
        // Generate a STARTUP file using the current values in the structure and return it as a string
        return ""
    }
    
}

class TPBIGS: NSObject
{
    // The URL of the executable
    var atpExecutable:URL
    
    // The STARTUP file string to use when running ATP. If this is nil, it is assumed that the file STARTUP that is located in the same directory as TPBIGS will be used.
    var STARTUP:URL? = nil
    
    // Designated initializer. Note that no check is done to verify that the URL is actually the executable ATP file. This verification should be made prior to creating the TPBIGS object.
    init(atpExecutable:URL)
    {
        self.atpExecutable = atpExecutable
    }
    
    enum RunAtpError: Error
    {
        case AtpError(errorLine:String)
        case NoStartupFileError
        case NoGraphicsFileError
        case NoGraphicsAuxFileError
        case AtpCouldNotRunError(errorLine:String)
    }
    
    func RunATP(inputFileString:String, arguments:[String] = [], STARTUP_FileString:String? = nil)
    {
        
    }
    
    func RunATP(inputURL:URL, arguments:[String] = [], STARTUP_URL:URL? = nil) throws
    {
        var useStartupURL = STARTUP_URL
        
        if useStartupURL == nil
        {
            useStartupURL = self.STARTUP
        }
        
        if useStartupURL == nil
        {
            
        }
        
    }

}
