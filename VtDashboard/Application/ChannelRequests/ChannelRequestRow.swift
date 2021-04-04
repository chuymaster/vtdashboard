import Kingfisher
import SwiftUI

struct ChannelRequestRow: View {

    @Binding var channelRequest: ChannelRequest
    let changeAction: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Link(destination: channelRequest.url) {
                AvatarIconImage(thumbnailImageUrl: channelRequest.thumbnailImageUrl)
                    .frame(width: 100, height: 100)
            }

            VStack(alignment: .leading) {
                HStack {
                    Text(channelRequest.title)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .lineLimit(1)
                    Spacer()
                    ChannelTypePicker(channelType: $channelRequest.type)
                        .fixedSize(horizontal: true, vertical: true)
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
                    title: "YuChan Channel YuChan Channel",
                    thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj",
                    type: .original,
                    status: .unconfirmed,
                    updatedAt: 0
                )
            ), changeAction: {}
        )
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
