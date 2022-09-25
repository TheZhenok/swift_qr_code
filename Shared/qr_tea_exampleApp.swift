//
//  qr_tea_exampleApp.swift
//  Shared
//
//  Created by ITSTEP on 23.09.2022.
//

import SwiftUI

@main
struct qr_tea_exampleApp: App {
    @StateObject var authentication = Authentication()
    @State var isReg: Bool = false
    var body: some Scene {
        WindowGroup {
            if authentication.isValidation {
                ContentView()
                    .environmentObject(authentication)
            } else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}
