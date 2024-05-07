import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false // control login status
    @EnvironmentObject var authModel: AuthenticationModel
    @EnvironmentObject var dataProvider: DataProvider
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Login") {
                    if authModel.authenticate(username: username, password: password) {
                        print("Login successful")
                        isLoggedIn = true //change boolean to true for navigation
                    } else {
                        print("Login failed")
                    }
                }
                .padding()
                
                NavigationLink("Register", destination: RegistrationView().environmentObject(authModel))//navigate to registration view
                    .padding()
                .navigationDestination(isPresented: $isLoggedIn) {
                    HomeView(username: username).environmentObject(dataProvider)//successful login will navigate to homeview
                }
            }
            .navigationTitle("Login")
        }
    }
}

