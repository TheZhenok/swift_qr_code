//
//  ProspectsView.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    enum FilterType{
        case none, people
    }
    
    @EnvironmentObject var prospects: Prospects
    @State var isPresetingScanner = false
    let filter: FilterType
    var body: some View {
        NavigationView {
        Text("People: \(prospects.people.count)")
            .navigationTitle(title)
            .toolbar {
                Button {
                    isPresetingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $isPresetingScanner) {
                CodeScannerView(codeTypes: [.qr], completion: handleScan)
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .people:
            return "People"
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isPresetingScanner = false
        switch result {
        case .success(let result):
            let deteil = result.string
            print(deteil)
            
        case .failure(let error):
            print("Scanning error: \(error)")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
