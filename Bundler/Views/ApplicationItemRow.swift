//
//  ApplicationItemRow.swift
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//

import SwiftUI

struct ApplicationItemRow: View {
    var applicationManager: ApplicationManager?
    var application: Application?
    var body: some View {
        HStack(spacing: 10){
            if application != nil {
                Image(uiImage: applicationManager!.applicationIconImageForBundleIdentifier((application?.bundleID)!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 7, style: .continuous)
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 0.5))
            } else {
                Image(systemName: "app.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            
            VStack(alignment: .leading){
                Text(application?.name ?? "Application")
                    .font(.headline)
                Text(application?.bundleID ?? "com.organization.app")
            }
        }
    }
}

struct ApplicationItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: ApplicationItemRow().preferredColorScheme)
            .previewLayout(.sizeThatFits)
    }
}
