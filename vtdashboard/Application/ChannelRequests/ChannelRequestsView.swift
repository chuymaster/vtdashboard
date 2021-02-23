import SwiftUI

struct ChannelRequestsView: View {
    @StateObject var viewModel = ChannelRequestsViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.channelRequests) { request in
                HStack {
                    ChannelRequestRow(
                        type: request.type,
                        status: request.status,
                        imageURL: request.thumbnailImageUrl, title: request.title
                    )
                    Spacer()
                }
            }
        }
    }
}

struct ChannelRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRequestsView(
            viewModel: ChannelRequestsViewModel(networkClient: MockNetworkClient())
        )
    }
}
