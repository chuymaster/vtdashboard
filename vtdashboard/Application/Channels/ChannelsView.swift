import SwiftUI

struct ChannelsView: View {
    
    var body: some View {
        VStack {
            ScrollView {
                // header + search box
                Text("Channels")
                    .bold()
                    .font(.title)
                
                // table
                LazyVStack {
                    ForEach(dummyChannels) { channel in
                        ChannelRow(
                            type: channel.type,
                            imageURL: channel.thumbnailImageUrl,
                            title: channel.title
                        )
                    }
                }
            }
        }
        .frame(minWidth: 300)
        .padding()
        
        // footer pagination
    }
}

struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView()
    }
}
