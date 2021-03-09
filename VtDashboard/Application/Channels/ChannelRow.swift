import Kingfisher
import SwiftUI

struct ChannelRow: View {
    
    @Binding var channel: Channel
    let updateAction: () -> Void
    let deleteAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Link(destination: channel.url) {
                KFImage(URL(string: channel.thumbnailImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text(channel.title)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .lineLimit(1)
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
        return ChannelRow(channel: .constant(channel), updateAction: {}, deleteAction: {})
    }
}
