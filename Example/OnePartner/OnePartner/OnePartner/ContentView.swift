//
//  ContentView.swift
//  OnePartner
//
//  Created by sunbin on 2025/6/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var quickActionSettings : QuickActionSettings
    
    @StateObject var router = Router()
    
    init() {
        
        let string = "https://clioapp.chinalife.com.hk/api/privacy/code/face"
        
        let parameter = ["lang":"zh_HK","tenant":"hk"]
        ApiService().fetch(User.self, string: string,method:.get,parameters: parameter)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in

                if case .failure(let error) = completion {
                }
            }, receiveValue: { users in

            })
            .store(in: &cancellables)
        
        
    }
    var body: some View {
        if #available(iOS 16.0, *) {
            
        }else{
            
        }
        NavigationStack(path: $router.path) {
            CustomerTabView()
        }
        .environmentObject(router)
        .navigationDestination(for: Tab.self) { target in
        }
        .onReceive(quickActionSettings.$quickAction) { shortcutItem in
            if shortcutItem == "" {
            }

        }
        
    }
}

#Preview {
    ContentView()
}
