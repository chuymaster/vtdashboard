import SwiftUI

struct ChannelRequestsView: View {
    @StateObject private var viewModel = ChannelRequestsViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            Text("Hello, World!")
                .padding()
            Spacer()
        }
    }
}

struct ChannelRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRequestsView()
    }
}
