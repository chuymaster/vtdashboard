import SwiftUI

struct OneLineTitleText: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
            .lineLimit(1)
    }
}

struct OneLineTitleText_Previews: PreviewProvider {
    static var previews: some View {
        OneLineTitleText(text: "Title")
            .previewLayout(.sizeThatFits)
    }
}
