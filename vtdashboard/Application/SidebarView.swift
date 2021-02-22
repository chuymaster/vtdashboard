//
//  SidebarView.swift
//  vtdashboard
//
//  Created by CHATCHAI LOKNIYOM on 2021/02/22.
//

import SwiftUI

struct SidebarView: View {
    @Binding var viewType: ViewType
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(ViewType.allCases, id: \.id) { viewType in
                HStack {
                    Text(viewType.rawValue)
                    Spacer()
                }
                .padding()
                .background(self.viewType == viewType ? Color.gray.opacity(0.2) : Color.clear)
                .onTapGesture {
                    self.viewType = viewType
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(viewType: .constant(.channels))
    }
}
