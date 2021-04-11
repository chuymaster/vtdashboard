import SwiftUI

struct ChannelTypeToggle: View {
    @Binding var isOriginalChannel: Bool

    var body: some View {
        Toggle("Original", isOn: $isOriginalChannel)
    }
}

struct ChannelTypeToggle_Previews: PreviewProvider {
    static var previews: some View {
        ChannelTypeToggle(isOriginalChannel: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
