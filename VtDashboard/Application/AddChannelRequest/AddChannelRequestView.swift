import SwiftUI

struct AddChannelRequestView: View {
    @State private var channelId = ""
    @State private var channelType = ChannelType.original
    @StateObject var viewModel = AddChannelRequestViewModel()
    
    private let maxCharacterCount = 24
    
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                TextField("Enter Channel ID", text: $channelId)
                    .font(.headline)
                if isAbleToSubmit {
                    Text("Channel ID must begin with UC, must be exact 24 characters.")
                        .font(.callout)
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            ChannelTypePicker(channelType: $channelType)
            
            Button(action: {
                viewModel.postChannelRequest(
                    id: channelId,
                    type: .original
                )
            }) {
                Text("Submit")
            }
            .keyboardShortcut(.defaultAction)
            .disabled(isAbleToSubmit)
            
            // TODO:- get random youtube channel info to show
            
            Spacer()
        }
        .padding()
        .alert(item: $viewModel.channelRequest) { channelRequest in
            Alert(
                title: Text("Submission Completed"),
                message: Text("\(channelRequest.title)\nType: \(channelRequest.type.displayText)"),
                dismissButton: .default(Text("Close")
                )
            )
        }
        .onChange(of: channelId) { value in
            if channelId.count > maxCharacterCount {
                channelId = String(channelId.prefix(maxCharacterCount))
            }
        }
    }
    
    private var isAbleToSubmit: Bool {
        channelId.prefix(2) != "UC" || channelId.count != maxCharacterCount
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
