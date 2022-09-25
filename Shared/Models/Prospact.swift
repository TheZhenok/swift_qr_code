//
//  Prospact.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI


class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymus"
    var emailAddress = ""
    var isContact = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
    
}
