//
//  APIService.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI


class APIService {
    static let shared = APIService()
    enum APIError: Error {
        case error
    }
    
    func login(
        user: User,
        complection: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void
    ) {
        print("APIService login")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if user.login == "87777777777" {
                complection(.success(true))
            } else {
                complection(.failure(.invalidUser))
            }
        }
    }
}
