import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Text("Loading...")
                .font(.title)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewLayout(.sizeThatFits)
    }
}
