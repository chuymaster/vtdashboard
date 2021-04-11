import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authenticationClient: AuthenticationClient
    @AppStorage(UserDefaultsKey.serverEnvironment.rawValue) var serverEnvironment: ServerEnvironmentValue = .development

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Picker("Server Environment",
                       selection: $serverEnvironment) {
                    ForEach(ServerEnvironmentValue.allCases) { environment in
                        Text(environment.rawValue)
                            .tag(environment)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .onChange(of: serverEnvironment, perform: { _ in
                    authenticationClient.signOut()
                })
            
                Text(Endpoint.baseURL.absoluteString)

                Link("Cloud Storage", destination: URL(string: "https://console.cloud.google.com/storage/browser/thaivtuberranking.appspot.com/channel_data?project=thaivtuberranking&pageState=(%22StorageObjectListTable%22:(%22f%22:%22%255B%255D%22))&prefix=&forceOnObjectsSortingFiltering=false")!)
                Link("Cloud Functions", destination: URL(string: "https://console.firebase.google.com/u/0/project/thaivtuberranking/functions/list")!)
                Link("BigQuery", destination: URL(string: "https://console.cloud.google.com/bigquery?project=thaivtuberranking&p=thaivtuberranking&page=project")!)
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
