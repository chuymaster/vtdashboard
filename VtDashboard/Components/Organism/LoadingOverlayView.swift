import SwiftUI

struct LoadingOverlayView: View {
    var body: some View {
        LoadingView()
            .ignoresSafeArea()
            .background(Color.black.opacity(0.3))
    }
}

struct LoadingOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlayView()
    }
}
