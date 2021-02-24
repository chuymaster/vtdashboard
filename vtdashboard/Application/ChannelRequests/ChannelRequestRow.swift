//import Kingfisher
//import SwiftUI
//
//struct ChannelRequestRow: View {
//
//    @Binding var channelRequest: ChannelRequest
//    let changeAction: () -> Void
//
//    var body: some View {
//        HStack(spacing: 16) {
//            KFImage(URL(string: channelRequest.thumbnailImageUrl))
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
//
//            VStack(alignment: .leading) {
//                HStack {
//                    Text(channelRequest.title)
//                        .font(.title)
//                        .bold()
//                    Spacer()
//                    Picker(
//                        selection: channelRequest.$type,
//                        label: Text("VTuber Type:")
//                            .bold()
//                            .fixedSize(horizontal: true, vertical: false)
//                    ) {
//                        Text("Original")
//                            .tag(ChannelType.original)
//                            .fixedSize(horizontal: true, vertical: false)
//                        Text("Half")
//                            .tag(ChannelType.half)
//                            .fixedSize(horizontal: true, vertical: false)
//                    }
//                    .pickerStyle(RadioGroupPickerStyle())
//                    Spacer()
//                }
//                HStack {
//                    TagText(title: channelRequest.status.displayText)
//                        .fixedSize(horizontal: true, vertical: true)
//                    Spacer()
//                    Button(action: {
//                        channelRequest.status = .accepted
//                    }, label: {
//                        Text("Register")
//                    })
////                    Button(action: pendingAction, label: {
////                        Text("Mark Pending")
////                    })
////                    Button(action: rejectAction, label: {
////                        Text("Reject")
////                    })
////                    Button(action: restoreAction, label: {
////                        Text("Restore")
////                    })
//                }
//            }
//            Spacer()
//        }
//        .padding()
//    }
//}
//
////struct ChannelRequestRow_Previews: PreviewProvider {
////    static var previews: some View {
////        ChannelRequestRow(
////            imageURL: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj",
////            title: "YuChan Channel",
////            updatedAt: "2021/2/14 12:00:00",
////            confirmAction: {},
////            pendingAction: {},
////            rejectAction: {},
////            unrejectAction: {}
////        )
////    }
////}
