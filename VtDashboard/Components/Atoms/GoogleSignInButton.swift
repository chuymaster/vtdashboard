import GoogleSignIn
import SwiftUI

struct GoogleSignInButton: View {
    let action: () -> Void
    
    var body: some View {
        _GoogleSignInButton(action: action)
            .frame(height: 48)
    }
}

private struct _GoogleSignInButton: UIViewRepresentable {
    let action: () -> Void
    
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.addAction(.init(handler: { _ in
            action()
        }), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton(action: {})
            .previewLayout(.sizeThatFits)
    }
}
