//
//  LoginView.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI

class CheckRegister: ObservableObject {
    @Published var isReg = false
}


struct RegisterView: View {
    @EnvironmentObject var checkRegister: CheckRegister
    @State var login = ""
    @State var email = ""
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
            TextField("Number", text: $login)
                .keyboardType(.numberPad)
            
            Button("Register") {
                guard let url = URL(string: "https://api.yii2-stage.test.wooppay.com/v1/registration/create-account") else { return }
                
                let body: [String: Any] = ["login": self.login, "email": self.email]
                let finalData = try! JSONSerialization.data(withJSONObject: body)
                print("Final Data: \(finalData)")
                print("Data: \(body)")
                var request = URLRequest(url: url)
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                request.httpBody = finalData
                
                URLSession.shared.dataTask(with: request) { data, res, err in
                    do {
                        if let httpResponse = res as? HTTPURLResponse {
                            print(httpResponse.statusCode)
                            if httpResponse.statusCode == 200 {
                                checkRegister.isReg = false
                            }
                        }
                        
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                }.resume()
            }
            
            .disabled(login.isEmpty || email.isEmpty)
            .padding(.bottom, 20)
        }
    }
}

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    @StateObject var checkRegister = CheckRegister()
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        if !checkRegister.isReg {
            VStack {
                Text("Sign in")
                    .font(.largeTitle)
                TextField("Login", text: $loginVM.user.login)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $loginVM.user.password)
                    .keyboardType(.numberPad)
                if loginVM.showProgressBar {
                    ProgressView()
                }
                
                Button("Log in") {
                    loginVM.login { success in
                        authentication.updateValidation(success: success)
                    }
                }
                .disabled(loginVM.loginDisable)
                .padding(.bottom, 20)
                
                Button("Register") {
                    self.checkRegister.isReg = true
                }
                .padding(.bottom, 20)
            }
            
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .disabled(loginVM.showProgressBar)
            .alert(item:  $loginVM.error) { error  in
                Alert(title: Text("Invalid user"), message: Text(error.localizedDescription))
            }
        } else {
            RegisterView()
                .environmentObject(checkRegister)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
