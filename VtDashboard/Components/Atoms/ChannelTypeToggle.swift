import SwiftUI

struct ChannelTypeToggle: View {
    @Binding var isOriginalChannel: Bool

    var body: some View {
        Toggle("Original", isOn: $isOriginalChannel)
            .font(.footnote)
            .toggleStyle(CheckboxStyle())
            .frame(maxWidth: 76)
    }
}

private struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {

            configuration.label

            Spacer()

            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .fixedSize(horizontal: true, vertical: true)

    }
}

struct ChannelTypeToggle_Previews: PreviewProvider {
    static var previews: some View {
        ChannelTypeToggle(isOriginalChannel: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
