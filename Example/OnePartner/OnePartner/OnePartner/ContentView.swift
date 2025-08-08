//
//  ContentView.swift
//  OnePartner
//
//  Created by sunbin on 2025/6/22.
//

import SwiftUI

import Models
import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
}
public struct Networking {
    static let shared:Networking = Networking()

    enum Component {
    case path
    }
    
    
}




extension Networking.Component : NetworkingProtocol{
    var baseURL: String{
        return "clioapp.chinalife.com.hk"
    }
    public var path: String {
        return "/api/privacy/code/face"
    }
    
    public var method: NetworkingManger.HttpMethod {
        return .get
    }
    
    public var parameter: NetworkingManger.HttpParameters? {
        return ["lang":"zh_HK","tenant":"hk"]
    }
    
    
}


struct ContentView: View {
    @EnvironmentObject var quickActionSettings : QuickActionSettings
    
    @StateObject var router = Router()
    
    init() {
        Networking.Component.path.performRequest(model: User.self).sink { completion in
            switch completion {
            case .failure(let error):
                
                break
            case .finished:
                print("00-0-----")

                break
            }
        } receiveValue: { users in
            DispatchQueue.main.async {
            }
        }.store(in: &cancellables)
        
        
        
//        let string = "https://clioapp.chinalife.com.hk/api/privacy/code/face"
//        
//        let parameter = ["lang":"zh_HK","tenant":"hk"]
//        ApiService().fetch(User.self, string: string,method:.get,parameters: parameter)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//
//                if case .failure(let error) = completion {
//                }
//            }, receiveValue: { users in
//
//            })
//            .store(in: &cancellables)
//        
        
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
