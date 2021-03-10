import SwiftUI

struct FilterBar: NSViewRepresentable {
    
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(binding: $text)
    }
    
    func makeNSView(context: Context) -> NSSearchField {
        let searchField = NSSearchField(string: text)
        searchField.delegate = context.coordinator
        searchField.bezelStyle = .roundedBezel
        searchField.focusRingType = .none
        return searchField
    }
    
    func updateNSView(_ nsView: NSSearchField, context: Context) {
        nsView.stringValue = text
    }
    
    class Coordinator: NSObject, NSSearchFieldDelegate {
        let binding: Binding<String>
        
        init(binding: Binding<String>) {
            self.binding = binding
            super.init()
        }
        
        func controlTextDidChange(_ obj: Notification) {
            guard let textField = obj.object as? NSTextField else { return }
            binding.wrappedValue = textField.stringValue
        }
    }
}
