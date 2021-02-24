import SwiftUI

struct ChannelRequestsView: View {
    @StateObject var viewModel = ChannelRequestsViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.channelRequests.indices) { index in
                let request = viewModel.channelRequests[index]
                HStack {
//                    ChannelRequestRow(
//                        type: viewModel.channelRequests[index].type,
//                        status: request.status,
//                        imageURL: request.thumbnailImageUrl,
//                        title: request.title,
//                        updatedAt: request.updatedAt.displayText,
//                        confirmAction: {
//
//                        },
//                        pendingAction: {
//
//                        },
//                        rejectAction: {
//
//                        },
//                        restoreAction: {
//
//                        }
//                    )
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
