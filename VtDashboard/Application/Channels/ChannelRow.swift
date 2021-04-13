import Kingfisher
import SwiftUI

struct ChannelRow: View {
    
    @Binding var channel: Channel
    private let iconSize: CGFloat = 80
    
    var body: some View {
        
        let isOriginalBinding = Binding(
            get: { channel.type == .original },
            set: { channel.type = $0 ? .original : .half }
        )
        
        HStack(spacing: 16) {
            AvatarIconImage(thumbnailImageUrl: channel.thumbnailImageUrl)
                .frame(width: iconSize, height: iconSize)
            
            VStack(alignment: .leading) {
                OneLineTitleText(text: channel.title)
                HStack(spacing: 24) {
                    ChannelTypeToggle(isOriginalChannel: isOriginalBinding)
                    VerticalIconNumeralText(
                        imageSystemName: "person.3",
                        text: channel.statistics?.subscribers ?? 0
                    )
                    .help("Followers")
                    VerticalIconNumeralText(
                        imageSystemName: "eye",
                        text: channel.statistics?.views ?? 0
                    )
                    .help("Views")
                }
            }
        }
        .help("Updated at \(channel.updatedAt.displayText)")
        .padding()
    }
}

struct ChannelRow_Previews: PreviewProvider {
    static var previews: some View {
        let channel = Channel(
            channelId: "1",
            title: "YuChan Channel",
            thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj",
            type: .original,
            updatedAt: 0
        )
        let placeholderChannel = Channel(
            channelId: "1",
            title: "YuChan Channel",
            thumbnailImageUrl: "https://",
            type: .original,
            updatedAt: 0
        )
        Group {
            ChannelRow(channel: .constant(channel))
            ChannelRow(channel: .constant(placeholderChannel))
        }
        .previewLayout(.sizeThatFits)
    }
}
