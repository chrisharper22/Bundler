//
//  ApplicationListView.swift
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//

import SwiftUI
import MobileCoreServices

struct ApplicationListView: View {
    
    let applicationManager = ApplicationManager.sharedManager
    
    @State public var systemApplications: [Application] = []
    @State public var userApplications: [Application] = []
    @State public var loaded: Bool = false
    
    @AppStorage("showHiddenApps") var showHiddenApps = false
    
    @State public var searchText = ""
    @State public var searchScopeSelection: Int = 0
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("System Applications")){
                    ForEach(systemApplications.sorted(by: {
                        $0.name! < $1.name!}
                    ).filter({
                        searchText.isEmpty || (searchScopeSelection == 0 ? $0.name!.lowercased().starts(with: searchText.lowercased()) : $0.bundleID!.lowercased().contains(searchText.lowercased()))
                    }), id: \.self) { application in
                        NavigationLink(
                            destination: ApplicationDetailView(applicationManager: applicationManager, application: application),
                            label: {
                                ApplicationItemRow(applicationManager: applicationManager, application: application)
                            })
                    }
                }
                Section(header: Text("User Applications")){
                    ForEach(userApplications.sorted(by: {
                        $0.name! < $1.name!}
                    ).filter({
                        searchText.isEmpty || (searchScopeSelection == 0 ? $0.name!.lowercased().starts(with: searchText.lowercased()) : $0.bundleID!.lowercased().contains(searchText.lowercased()))
                    }), id: \.self) { application in
                        NavigationLink(
                            destination: ApplicationDetailView(applicationManager: applicationManager, application: application),
                            label: {
                                ApplicationItemRow(applicationManager: applicationManager, application: application)
                            })
                    }
                }
            }
            .onAppear(){
                if !self.loaded {
                    fetchApplications()
                    self.loaded = true
                }
            }
            .onChange(of: self.showHiddenApps, perform: { value in
                fetchApplications()
            })
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    Toggle("Show Hidden", isOn: $showHiddenApps.animation())
                        .toggleStyle(SwitchToggleStyle(tint: Color(.systemPink)))
                }
            }
            .navigationBarTitle("Applications")
            .navigationSearchBar(text: $searchText, scopeSelection: $searchScopeSelection, options: [.automaticallyShowsSearchBar: true, .hidesSearchBarWhenScrolling: false, .scopeButtonTitles: ["Name", "Bundle ID"]])
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func fetchApplications() {
        let applications = ApplicationManager.sharedManager.allInstalledApplications()
        let systemApplications = applications.filter({$0.type == .system})
        let userApplications = applications.filter({$0.type == .user})
        self.systemApplications = self.showHiddenApps ? systemApplications : systemApplications.filter({!self.hiddenApp($0)})
        self.userApplications = self.showHiddenApps ? userApplications : userApplications.filter({!self.hiddenApp($0)})
    }
    
    
    private func hiddenApp(_ application: Application) -> Bool {
        guard let bundlePath = application.bundlePath, let plistData = try? Data(contentsOf: bundlePath.appendingPathComponent("Info.plist")),
              let plist = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any] else {
            return true
        }
        if let tags = plist["SBAppTags"] as? [String], tags.contains("hidden") {
            return true
        }
        if let visibility = plist["SBIconVisibilityDefaultVisible"] as? Bool, !visibility {
            return true
        }
        return false
    }
}

struct ApplicationListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: ApplicationListView().preferredColorScheme)
    }
}
