//
//  ContentView.swift
//  OnePartner
//
//  Created by sunbin on 2025/6/22.
//

import SwiftUI

import Models
import Foundation
import ReerCodable
struct User: Codable, Identifiable {
    let id: Int
    let name: String
}

struct FaceAuthData: Codable, Identifiable {
    let id: String
    let title: String

   
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
    
    public var method: HttpMethod {
        return .get
    }
    
    public var parameter: HttpParameters? {
        return ["lang":"zh_HK","tenant":"hk"]
    }
    
    
}


struct ContentView: View {
    @EnvironmentObject var quickActionSettings : QuickActionSettings
    
    @StateObject var router = Router()
    
    init() {
        Networking.Component.path.performRequest(model: FaceAuthData.self).sink { completion in
            switch completion {
            case .failure(let error):
                print("00-0-----error=\(error)")
                break
            case .finished:
                print("00-0-----finished")
                break
            }
        } receiveValue: { users in
            print("00-0--users---\(users.data?.title)")
            DispatchQueue.main.async {
            }
        }.store(in: &cancellables)
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
