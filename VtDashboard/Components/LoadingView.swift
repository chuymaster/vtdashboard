import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.clear
            Spinner()
                .frame(width: 100, height: 100, alignment: .center)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewLayout(.sizeThatFits)
    }
}
