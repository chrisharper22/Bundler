//
//  ApplicationManager.swift
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//  Copyright © 2021 Simalary (Chris). All rights reserved.
//

import Foundation
import UIKit

class ApplicationManager: NSObject {
    static let sharedManager = ApplicationManager()
    fileprivate var workspace: LSApplicationWorkspace?
    
    
    override init() {
        workspace = LSApplicationWorkspace.default()
    }
    
    func allInstalledApplications() -> [Application]{
        guard let workspace = workspace else { //protect
            return []
        }
        var applications = [Application]()
        let installedApplicationProxies = workspace.allInstalledApplications()
        
        for applicationProxy in installedApplicationProxies {
            
            let bundleIdentifier = applicationProxy.applicationIdentifier()
            let appIcon = self.applicationIconImageForBundleIdentifier(bundleIdentifier!)
            
            /* Create and map a system application object to LSApplicationProxys variables */
            let app = Application()
            app.map(bundleID: bundleIdentifier,
                    name: applicationProxy.localizedName(),
                    bundlePath: applicationProxy.bundleURL(),
                    version: applicationProxy.shortVersionString(),
                    executableName: applicationProxy.bundleExecutable(),
                    type: applicationProxy.applicationType(),
                    signerIdentity: applicationProxy.signerIdentity(),
                    applicationPath: applicationProxy.dataContainerURL(),
                    backgroundModes: applicationProxy.uiBackgroundModes() as? [String],
                    entitlements: applicationProxy.entitlements() as? [String : Any],
                    icon: appIcon
            )
            
            applications.append(app)
        }
        
        return applications
    }
    
    
    @discardableResult func openApplication(_ app: Application) -> Bool {
        if let workspace = workspace {
            return workspace.openApplication(withBundleID: app.bundleID)
        }
        return false
    }
    
    @discardableResult func openApplication(bundleID: String) -> Bool {
        if let workspace = workspace {
            return workspace.openApplication(withBundleID: bundleID)
        }
        return false
    }
    
    func applicationIconImageForBundleIdentifier(_ bundleID: String) -> UIImage?{
        return UIImage._applicationIconImage(forBundleIdentifier: bundleID, format: 2, scale: Double(UIScreen.main.scale)) as? UIImage
    }
    
}
