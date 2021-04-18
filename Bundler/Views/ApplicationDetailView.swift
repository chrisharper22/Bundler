//
//  ApplicationDetailView.swift
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//  Copyright © 2021 Simalary (Chris). All rights reserved.
//

import SwiftUI

struct ApplicationDetailView: View {
    var applicationManager: ApplicationManager? = nil
    var application: Application? = nil
    var body: some View {
        Form{
            Section(header: Text("Information")){
                HStack{
                    Text("Name")
                    Spacer()
                    Text(application?.name ?? "Application")
                        .foregroundColor(.secondary)
                }
                HStack{
                    Text("Identifier")
                    Spacer()
                    Text(application?.bundleID ?? "com.organization.app")
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
                HStack{
                    Text("Executable Name")
                    Spacer()
                    Text(application?.executableName ?? "??")
                        .foregroundColor(.secondary)
                }
                HStack{
                    Text("Version")
                    Spacer()
                    Text(application?.version ?? "0.0")
                        .foregroundColor(.secondary)
                }
                HStack{
                    Text("Type")
                    Spacer()
                    Text(application?.type == .system ? "System" : "User")
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
            }
            Section{
                VStack(alignment: .leading){
                    Text("Background Modes")
                    ForEach(application?.backgroundModes ?? ["??"], id: \.self) {mode in
                        Text(mode)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.secondary)
                    }
                }.padding(.vertical, 5)
            }
            Section(header: Text("Paths")){
                HStack{
                    Text("Bundle Path")
                    Spacer()
                    Text(application?.bundlePath?.path ?? "??")
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
                HStack{
                    Text("Container Path")
                    Spacer()
                    Text(application?.applicationPath?.path ?? "??")
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
            }
            Section(header: Text("Entitlements (Beta)")){
                Text(application?.entitlements?.description ?? "??")
            }
        }.navigationBarTitle(application?.name ?? "Application", displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar{
            ToolbarItem(placement: ToolbarItemPlacement.confirmationAction){
                Button("Open") {
                    applicationManager!.openApplication(application!)
                }
            }
        }
    }
}

struct ApplicationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: ApplicationDetailView().preferredColorScheme)
    }
}
