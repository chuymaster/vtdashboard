import SwiftUI

struct CaptionText: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundColor(.gray)
    }
}

struct CaptionText_Previews: PreviewProvider {
    static var previews: some View {
        CaptionText(text: "caption")
            .previewLayout(.sizeThatFits)
    }
}
