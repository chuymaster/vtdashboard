import SwiftUI

struct ImageLabel: View {
    let iconImageName: String
    let label: String
    var isBold: Bool = false

    var body: some View {
        HStack {
            Image(systemName: iconImageName)
                .frame(minWidth: 30)
            if isBold {
                Text(label)
                    .bold()
            } else {
                Text(label)
            }
            Spacer()
        }
    }
}

struct ImageLabel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImageLabel(iconImageName: "clock", label: "Label")

            ImageLabel(iconImageName: "clock", label: "Label", isBold: true)
        }
    }
}
