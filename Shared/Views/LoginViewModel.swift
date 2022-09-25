//
//  LoginView.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var user = User()
    @Published var error: Authentication.AuthenticationError?
    @Published var showProgressBar = false
    
    var loginDisable: Bool {
        user.login.isEmpty || user.password.isEmpty
    }
    
    func login(complection: @escaping (Bool) -> Void) {
        print("LoginVM login")
        showProgressBar = true
        APIService.shared.login(user:  user) { [unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
            showProgressBar = false
            switch result {
            case .success:
                complection(true)
            case .failure(let authError):
                user = User()
                error = authError
                complection(false)
            }
        }
    }
}



