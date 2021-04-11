import SwiftUI

struct TagText: View {
    let title: String
    var backgroundColor = Color.blue

    var body: some View {
        Text(title)
            .font(.caption)
            .bold()
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(16)
            .fixedSize(horizontal: true, vertical: true)
    }
}

struct TagText_Previews: PreviewProvider {
    static var previews: some View {
        TagText(title: "Tag")
            .previewLayout(.sizeThatFits)
    }
}
