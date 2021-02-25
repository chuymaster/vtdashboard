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
                    Text(channelRequest.title)
                        .font(.title)
                        .bold()
                    Spacer()
                    Picker(
                        selection: $channelRequest.type,
                        label: Text("VTuber Type:")
                            .bold()
                            .fixedSize(horizontal: true, vertical: false)
                    ) {
                        Text("Original")
                            .tag(ChannelType.original)
                            .fixedSize(horizontal: true, vertical: false)
                        Text("Half")
                            .tag(ChannelType.half)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .pickerStyle(RadioGroupPickerStyle())
                    Spacer()
                }
                HStack {
                    TagText(title: channelRequest.status.displayText)
                    Spacer()
                    Button(
                        action: {
                            channelRequest.status = .accepted
                            changeAction()
                        }, label: {
                            Text("Accept")
                        })
                    Button(
                        action: {
                            channelRequest.status = .pending
                            changeAction()
                        }, label: {
                            Text("Mark Pending")
                        })
                    Button(
                        action: {
                            channelRequest.status = .rejected
                            changeAction()}, label: {
                                Text("Reject")
                            })
                    Button(
                        action: {
                            channelRequest.status = .unconfirmed
                            changeAction()}, label: {
                                Text("Restore")
                            })
                }
            }
            Spacer()
        }
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

