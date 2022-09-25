//
//  Authentication.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI


class Authentication: ObservableObject {
    @Published var isValidation: Bool = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidUser
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidUser:
                return NSLocalizedString("Error number or email. Please try again", comment: "")
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidation = success
        }
    }
}
