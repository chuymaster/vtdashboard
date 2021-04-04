import Kingfisher
import SwiftUI

struct ChannelRow: View {

    @Binding var channel: Channel
    let updateAction: () -> Void
    let deleteAction: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Link(destination: channel.url) {
                AvatarIconImage(thumbnailImageUrl: channel.thumbnailImageUrl)
                    .frame(width: 100, height: 100)
            }

            VStack(alignment: .leading) {
                HStack {
                    Text(channel.title)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .lineLimit(1)
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "person.3")
                                .frame(width: 28)
                            Text("\(channel.statistics?.subscribers ?? 0)")
                                .font(.caption)
                        }
                        .help("Follower")
                        HStack {
                            Image(systemName: "eye")
                                .frame(width: 28)
                            Text("\(channel.statistics?.views ?? 0)")
                                .font(.caption)
                        }
                        .help("Views")
                    }
                }
                HStack {
                    ChannelTypePicker(channelType: $channel.type)
                    Spacer()
                    Button(
                        action: updateAction,
                        label: {
                            Text("Update")
                        })
                        .cornerRadius(4)
                    Button(
                        action: deleteAction,
                        label: {
                            Text("Delete")
                        })
                        .background(Color.red)
                        .cornerRadius(4)
                }
            }
            Spacer()
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
            ChannelRow(channel: .constant(channel), updateAction: {}, deleteAction: {})
            ChannelRow(channel: .constant(placeholderChannel), updateAction: {}, deleteAction: {})
        }
    }
}
