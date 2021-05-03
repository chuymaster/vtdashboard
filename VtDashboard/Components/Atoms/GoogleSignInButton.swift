import GoogleSignIn
import SwiftUI

struct GoogleSignInButton: View {
    var body: some View {
        _GoogleSignInButton()
            .frame(height: 48)
    }
}

private struct _GoogleSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .light
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton()
            .previewLayout(.sizeThatFits)
    }
}
