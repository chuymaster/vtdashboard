import SwiftUI

/// Loading Spinner
/// Refer to:  https://medium.com/swlh/swiftui-animations-loading-spinner-2e01a3d8e9c0
struct Spinner: View {
    @State var spinnerStart: CGFloat = 0.0
    @State var rotationDegreeS1 = initialDegree
    @State var rotationDegreeS2 = initialDegree
    
    private static let initialDegree: Angle = .degrees(270)
    
    private let animationTime: Double = 1
    private let rotationTime: Double = 0.75
    private let fullRotation: Angle = .degrees(360)
    
    var body: some View {
        ZStack {
            // S2
            SpinnerCircle(start: 0.5, end: 0.6, rotation: rotationDegreeS2, color: .purple)
            
            // S1
            SpinnerCircle(start: 0, end: 0.9, rotation: rotationDegreeS1, color: .blue)
        }
        .onAppear() {
            animateSpinner()
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { timer in
                animateSpinner()
            }
        }
    }
    
    private func animateSpinner() {
        
        withAnimation(Animation.easeInOut(duration: rotationTime)) {
            rotationDegreeS1 += fullRotation
        }
        
        withAnimation(Animation.easeInOut(duration: rotationTime * 2 + 0.525)) {
            rotationDegreeS2 += fullRotation
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
            .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Spinner()
        }
    }
}
