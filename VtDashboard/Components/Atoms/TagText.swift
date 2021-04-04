import SwiftUI

struct TagText: View {
    let title: String
    var backgroundColor = Color.blue

    var body: some View {
        Text(title)
            .font(.title3)
            .bold()
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
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
