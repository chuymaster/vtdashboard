import Kingfisher
import SwiftUI

struct ChannelRequestRow: View {
    
    @Binding var channelRequest: ChannelRequest
    let changeAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: channelRequest.thumbnailImageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HStack {
                    Link(destination: channelRequest.url) {
                        Text(channelRequest.title)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                    }
                    Spacer()
                    ChannelTypePicker(channelType: $channelRequest.type)
                }
                HStack {
                    TagText(
                        title: channelRequest.status.displayText,
                        backgroundColor: channelRequest.status.backgroundColor
                    )
                    Spacer()
                    Button(
                        action: {
                            channelRequest.status = .accepted
                            changeAction()
                        }, label: {
                            Text("Accept")
                        })
                        .disabled(channelRequest.status == .accepted || channelRequest.status == .rejected)
                    Button(
                        action: {
                            channelRequest.status = .pending
                            changeAction()
                        }, label: {
                            Text("Mark Pending")
                        })
                        .disabled(channelRequest.status != .unconfirmed)
                    Button(
                        action: {
                            channelRequest.status = .rejected
                            changeAction()}, label: {
                                Text("Reject")
                            })
                        .disabled(channelRequest.status == .rejected || channelRequest.status == .accepted)
                    Button(
                        action: {
                            channelRequest.status = .unconfirmed
                            changeAction()}, label: {
                                Text("Restore")
                            })
                        .disabled(channelRequest.status != .rejected)
                }
            }
            Spacer()
        }
        .help("Updated at \(channelRequest.updatedAt.displayText)")
        .padding()
    }
}

struct ChannelRequestRow_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRequestRow(
            channelRequest: .constant(
                .init(
                    channelId: "1",
                    title: "YuChan Channel",
                    thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj",
                    type: .original,
                    status: .unconfirmed,
                    updatedAt: 0
                )
            ), changeAction: {}
        )
    }
}

