import SwiftUI

extension Alert: Identifiable {
    public var id: String { UUID().uuidString }
}
