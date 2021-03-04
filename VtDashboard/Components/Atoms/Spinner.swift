import SwiftUI

/// Loading Spinner
/// Refer to:  https://medium.com/swlh/swiftui-animations-loading-spinner-2e01a3d8e9c0
struct Spinner: View {
    @State private var spinnerStart: CGFloat = 0.0
    @State private var spinnerEndS1: CGFloat = 0.03
    @State private var rotationDegreeS1 = initialDegree
    
    private static let initialDegree: Angle = .degrees(270)
    
    private let animationTime: Double = 1.9
    private let rotationTime: Double = 0.75
    private let fullRotation: Angle = .degrees(360)

    var body: some View {
        ZStack {
            SpinnerCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: .blue)
        }.frame(width: 200, height: 200)
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { timer in
                self.animateSpinner()
            }
        }
    }
    
    // MARK: Animation methods
    private func animateSpinner(with timeInterval: Double, completion: @escaping (() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: rotationTime)) {
                completion()
            }
        }
    }
    
    private func animateSpinner() {
        animateSpinner(with: rotationTime) {
            self.spinnerEndS1 = 1.0
        }
        animateSpinner(with: (rotationTime * 2)) {
            self.spinnerEndS1 = 0.03
        }
        animateSpinner(with: (rotationTime * 2) - 0.025) {
            self.rotationDegreeS1 += fullRotation
        }
    }
}

private struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color

    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
