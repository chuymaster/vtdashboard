import SwiftUI

struct SidebarView: View {
    @Binding var viewType: ViewType?
    
    var body: some View {
        List(selection: $viewType) {
            ForEach(ViewType.allCases) { viewType in
                ImageLabel(iconImageName: viewType.iconImageName, label: viewType.rawValue)
                .tag(viewType)
            }
        }
        .listStyle(SidebarListStyle())
    }
    
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(viewType: .constant(.channels))
    }
}
