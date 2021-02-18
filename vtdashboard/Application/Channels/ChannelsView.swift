import SwiftUI

struct ChannelsView: View {
    
    @StateObject private var viewModel = ChannelsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            // header + search box
            Text("Channels")
                .bold()
                .font(.title)
            
            List {
                ForEach(viewModel.channels) { channel in
                    ChannelRow(
                        type: channel.type,
                        imageURL: channel.thumbnailImageUrl,
                        title: channel.title
                    )
                }
            }
            .listStyle(PlainListStyle())
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
