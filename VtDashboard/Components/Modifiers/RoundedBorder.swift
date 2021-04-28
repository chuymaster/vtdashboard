import SwiftUI

struct RoundedBorder: ViewModifier {
    
    var cornerRadius: CGFloat = 8
    var strokeColor = Color.gray
    var lineWidth: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}
