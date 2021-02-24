import SwiftUI

struct TagText: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .bold()
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(Color.blue)
            .cornerRadius(16)
    }
}

struct TagText_Previews: PreviewProvider {
    static var previews: some View {
        TagText(title: "Tag")
            .previewLayout(.sizeThatFits)
    }
}
