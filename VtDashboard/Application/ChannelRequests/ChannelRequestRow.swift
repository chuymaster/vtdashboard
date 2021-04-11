import Kingfisher
import SwiftUI

struct ChannelRequestRow: View {

    @Binding var channelRequest: ChannelRequest

    var body: some View {
        HStack {

            let isOriginalBinding = Binding(
                get: { channelRequest.type == .original },
                set: { channelRequest.type = $0 ? .original : .half }
            )

            HStack(spacing: 8) {
                AvatarIconImage(thumbnailImageUrl: channelRequest.thumbnailImageUrl)
                    .frame(width: 80, height: 80)

                VStack(alignment: .leading) {
                    Text(channelRequest.title)
                        .font(.title2)
                        .bold()
                        .lineLimit(1)
                    HStack(spacing: 16) {
                        ChannelTypeToggle(isOriginalChannel: isOriginalBinding)
                            .frame(maxWidth: 72)
                        TagText(
                            title: channelRequest.status.displayText,
                            backgroundColor: channelRequest.status.backgroundColor
                        )
                        Spacer()
                    }
                }
            }
        }
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
