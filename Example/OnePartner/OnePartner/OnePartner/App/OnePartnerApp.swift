//
//  OnePartnerApp.swift
//  OnePartner
//
//  Created by sunbin on 2025/6/22.
//

import SwiftUI

@main
struct OnePartnerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var phase
    
    @StateObject private var quickActionSettings = QuickActionSettings()

    init() {
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quickActionSettings)
        }
        .onChange(of: phase) { (phaseValue) in
            switch phaseValue {
            case .active:
                print("App: -> .active")
                print("快捷入口")
                guard let actionName = shortcutItemToProcess?.type as? String else { return }
                quickActionSettings.quickAction = actionName
                
            case .background:
                print("App: -> .background")
            case .inactive:
                print("App: -> .inactive")
            @unknown default:
                print("App: -> Default")
            }
        }
    }
}













