import SwiftUI

struct AddChannelRequestView: View {
    @State private var channelId = ""
    @State private var channelType = ChannelType.original
    @StateObject var viewModel = AddChannelRequestViewModel()
    
    var body: some View {
        VStack {
            Text("Request new channel")
                .font(.title2)
            TextField("Enter Channel ID", text: $channelId)
                .font(.body)
                .padding()
            ChannelTypePicker(channelType: $channelType)
            Button(action: {
                viewModel.postChannelRequest(id: channelId, type: .original)
            }) {
                Text("Submit")
            }
            Spacer()
        }
        .padding()
        .alert(item: $viewModel.channelRequest) { channelRequest in
            Alert(title: Text("Submission Completed"), message: Text("\(channelRequest.title)\nType: \(channelRequest.type.displayText)"), dismissButton: .default(Text("Close")))
        }
    }
}

struct AddChannelRequestView_Previews: PreviewProvider {
    static var previews: some View {
        AddChannelRequestView(
            viewModel: .init(networkClient: MockNetworkClient()
            )
        )
    }
}
