//
//  WaiterView.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI
import CodeScanner


struct WaiterView: View {
    @StateObject var prospects = Prospects()
    @State var isPresetingScanner = false
    @State var scannedCode: String = "Scan QR get code to get started"
    
    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresetingScanner = false
                }
            }
        )
    }
    
    var body: some View {
        TabView {
            ProspectsView(filter: .people)
                .tabItem {
                    Label("Profile", systemImage: "checkmark.circle")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

struct WaiterView_Previews: PreviewProvider {
    static var previews: some View {
        WaiterView()
    }
}
