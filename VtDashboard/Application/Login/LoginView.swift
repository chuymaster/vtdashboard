import SwiftUI

struct LoginView: View {

    @StateObject var viewModel: LoginViewModel

    var body: some View {
        GeometryReader { _ in
            VStack {
                Button(action: viewModel.signup, label: {
                    Text("Sign Up")
                })
                Button(action: viewModel.signin, label: {
                    Text("Sign In")
                })
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(authenticationClient: AuthenticationClient.shared))
    }
}
