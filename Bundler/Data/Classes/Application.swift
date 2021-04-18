//
//  Application.swift
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//  Copyright © 2021 Simalary (Chris). All rights reserved.
//

import UIKit

enum ApplicationType{
    case system
    case user
}

class Application: NSObject {
    var bundleID: String?
    var name: String? //Springboard display name
    var bundlePath: URL?
    var version: String?
    var executableName: String? //Name of internal payload executable
    var type: ApplicationType?
    var signerIdentity: String?
    var applicationPath: URL?
    var backgroundModes: [String]?
    var entitlements: [String : Any]?
    var icon: UIImage?
    
    override init(){
        super.init()
    }
    
    init(bundleID: String){
        super.init()
        self.bundleID = bundleID
    }
    
    /*
     Mapping function.
     Pass nil for any parameter not given
    */
    func map(bundleID: String?,
        name: String?,
        bundlePath: URL?,
        version: String?,
        executableName: String?,
        type: String?,
        signerIdentity: String?,
        applicationPath: URL?,
        backgroundModes: [String]?,
        entitlements: [String : Any]?,
        icon: UIImage?
        ){
        
        self.bundleID = bundleID
        self.name = name
        self.bundlePath = bundlePath
        self.version = version
        self.executableName = executableName
        if type == "System"{
            self.type = .system
        }
        else{
            self.type = .user
        }
        self.signerIdentity = signerIdentity
        self.applicationPath = applicationPath
        self.backgroundModes = backgroundModes
        self.entitlements = entitlements
        self.icon = icon
    }
   
    
    
}
