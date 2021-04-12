import Kingfisher
import SwiftUI

struct AvatarIconImage: View {
    let thumbnailImageUrl: String

    var body: some View {
        KFImage(URL(string: thumbnailImageUrl))
            .placeholder {
                Image(systemName: "person.circle")
                    .font(.system(size: 80))
            }
            .cancelOnDisappear(true)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
}

struct AvatarIconImage_Previews: PreviewProvider {
    static var previews: some View {
        AvatarIconImage(thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj")
            .previewLayout(.sizeThatFits)
    }
}
