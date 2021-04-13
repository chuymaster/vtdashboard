import SwiftUI

struct AddChannelRequestView: View {
    @State private var channelId = ""
    @State private var channelType = ChannelType.original
    @State private var selectedChannelId: String!
    @StateObject var viewModel = AddChannelRequestViewModel()
    @EnvironmentObject private var uiState: UIState

    private let maxCharacterCount = 24

    var body: some View {
        VStack {
            VStack {
                TextField("Enter Channel ID", text: $channelId)
                    .font(.headline)
                    .padding()
                    .border(Color.gray, width: 2)
                if isSubmissionDisabled {
                    Text("Channel ID must begin with UC, must be exact 24 characters.")
                        .font(.callout)
                        .foregroundColor(.red)
                }
            }
            .padding()

            let isOriginalBinding = Binding(
                get: { channelType == .original },
                set: { channelType = $0 ? .original : .half }
            )
            ChannelTypeToggle(isOriginalChannel: isOriginalBinding)
                .padding(.bottom)

            Divider()

            Text("Sample Channel IDs for debugging")
                .bold()
            List(viewModel.sampleChannelIds, selection: $selectedChannelId) {
                Text($0)
            }
            .environment(\.editMode, .constant(.active))
            .frame(maxHeight: 300)

            Spacer()
        }
        .toolbar {
            Button(action: {
                viewModel.postChannelRequest(
                    id: channelId,
                    type: channelType
                )
            }) {
                Text("Submit")
            }
            .keyboardShortcut(.defaultAction)
            .disabled(isSubmissionDisabled)
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
        .onChange(of: selectedChannelId, perform: { _ in
            channelId = selectedChannelId
        })
        .onChange(of: channelId) { _ in
            if channelId.count > maxCharacterCount {
                channelId = String(channelId.prefix(maxCharacterCount))
            }
        }
        .onReceive(viewModel.$viewStatus, perform: { status in
            uiState.isLoadingBlockingUserInteraction = status == .loading
        })
    }

    private var isSubmissionDisabled: Bool {
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
