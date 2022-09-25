//
//  User.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI


let PRODHOST: String = "https://api.yii2-stage.test.wooppay.com"
let LOCALHOST: String = "http://172.28.0.76:8000/api/v1"

class UserPostModel: Decodable {
    var login: String = ""
    var email: String = ""
}

struct SuccessRequest: Decodable {
    var parent_login: String
    var subject_type: Int
    var country: Int
    var id: Int
    var login: String
    var status: Int
    var roles: [String]
    var assignments: String
    var token: String
    var email: String
    var created_at: String
    var identified: Int
    var resident_kz: String
}


class User: Decodable {
    var login: String = ""
    var password: String = ""
}


class UserViewModel: ObservableObject {
    func loadData() {
        guard let url = URL(string: PRODHOST) else { return }
        
        let body: [String: Any] = ["login": "87088447870", "email": "zenjaprihan@yandex.ru"]
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        print("Final Data: \(finalData)")
        print("Data: \(body)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, res, err in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(SuccessRequest.self, from: data)
                    print(result)
                    
                } else {
                    print("No data")
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
