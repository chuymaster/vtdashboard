import Kingfisher
import SwiftUI

struct ChannelRow: View {
    
    @State var type: ChannelType = .original
    let imageURL: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: imageURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .bold()
                ChannelTypePicker(channelType: $type)
            }
            Spacer()
        }
        .padding()
    }
}

struct ChannelRow_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRow(
            imageURL: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj",
            title: "YuChan Channel"
        )
    }
}
