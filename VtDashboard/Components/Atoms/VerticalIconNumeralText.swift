import SwiftUI

struct VerticalIconNumeralText: View {
    let imageSystemName: String
    let text: Int

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: imageSystemName)
                .frame(width: 16, height: 16)
            Text("\(text)")
                .font(.caption)
        }
        .fixedSize(horizontal: true, vertical: true)
    }
}

struct VerticalIconText_Previews: PreviewProvider {
    static var previews: some View {
        VerticalIconNumeralText(imageSystemName: "eye", text: 12345)
            .previewLayout(.sizeThatFits)
    }
}
