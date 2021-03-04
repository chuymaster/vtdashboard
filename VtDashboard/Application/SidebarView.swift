import SwiftUI

struct SidebarView: View {
    @Binding var viewType: ViewType?
//    @Binding var ss: String
    
    var body: some View {
        List(selection: $viewType) {
            ForEach(ViewType.allCases) { viewType in
                HStack {
                    Image(systemName: viewType.iconImageName)
                        .frame(minWidth: 30)
                    Text(viewType.rawValue)
                    Spacer()
                }
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
