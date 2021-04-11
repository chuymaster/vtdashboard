import SwiftUI

struct ChannelTypePicker: View {
    @Binding var channelType: ChannelType

    var body: some View {
        Picker(
            selection: $channelType,
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
        .pickerStyle(MenuPickerStyle())
    }
}

struct ChannelTypePicker_Previews: PreviewProvider {
    static var previews: some View {
        ChannelTypePicker(channelType: .constant(.original))
    }
}
