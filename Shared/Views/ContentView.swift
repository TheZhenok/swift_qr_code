//
//  ContentView.swift
//  Shared
//
//  Created by ITSTEP on 23.09.2022.
//

import SwiftUI


struct ContentView: View {
    @State var login: String = ""
    @State var number: String = ""
    @ObservedObject var userVM = UserViewModel()
    
    var body: some View {
        WaiterView()
        .onAppear(perform: {
            userVM.loadData()
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
