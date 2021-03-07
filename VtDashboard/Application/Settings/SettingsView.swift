import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultsKey.serverEnvironment.rawValue) var serverEnvironment: ServerEnvironmentValue = .development
    
    var body: some View {
        ZStack {
            VStack {
                Picker("Server Environment",
                       selection: $serverEnvironment) {
                    ForEach(ServerEnvironmentValue.allCases) { environment in
                        Text(environment.rawValue)
                            .tag(environment)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                
                Text(Endpoint.baseURL.absoluteString)
                Spacer()
            }
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
