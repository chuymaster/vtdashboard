import Kingfisher
import SwiftUI

struct ChannelRequestRow: View {

    @Binding var channelRequest: ChannelRequest

    private let iconSize: CGFloat = 80

    var body: some View {
        HStack {
            let isOriginalBinding = Binding(
                get: { channelRequest.type == .original },
                set: { channelRequest.type = $0 ? .original : .half }
            )

            HStack(spacing: 8) {
                AvatarIconImage(thumbnailImageUrl: channelRequest.thumbnailImageUrl)
                    .frame(width: iconSize, height: iconSize)

                VStack(alignment: .leading) {
                    OneLineTitleText(text: channelRequest.title)
                    HStack(spacing: 16) {
                        ChannelTypeToggle(isOriginalChannel: isOriginalBinding)
                        TagText(
                            title: channelRequest.status.displayText,
                            backgroundColor: channelRequest.status.backgroundColor
                        )
                        Spacer()
                    }
                }
            }
        }
        .help("Updated at \(channelRequest.updatedAt.displayText)")
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
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
