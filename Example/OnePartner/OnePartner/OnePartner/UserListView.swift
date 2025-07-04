//
//  UserListView.swift
//  OnePartner
//
//  Created by bin sun on 2025/7/4.
//

import Foundation
import SwiftUI

struct UserListView: View {
    @StateObject var viewModel = UserViewModel()
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationView {
            

//            Group {
//                if viewModel.isLoading && viewModel.users.isEmpty {
//                    ProgressView("加载用户数据...")
//                } else if let error = viewModel.error {
//                    ErrorView(error: error, retryAction: viewModel.loadUsers)
//                } else {
//                    List(viewModel.users) { user in
//                        NavigationLink(destination: Text("")) {
//                            VStack(alignment: .leading) {
//                                Text(user.formattedName)
//                                    .font(.headline)
//                                Text(user.email)
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                            }
//                        }
//                    }
//                    .refreshable {
//                        viewModel.refreshUsers()
//                    }
//                }
//            }
//            .navigationTitle("用户列表")
//            .toolbar {
//                if !viewModel.isLoading {
//                    Button(action: viewModel.refreshUsers) {
//                        Label("刷新", systemImage: "arrow.clockwise")
//                    }
//                }
//            }
        }
        .onAppear {
            if networkMonitor.isConnected {
                viewModel.loadUsers()
            } else {
                viewModel.error = .noInternetConnection
            }
        }
        .alert(isPresented: .constant(viewModel.error != nil && !networkMonitor.isConnected)) {
            Alert(
                title: Text("网络错误"),
                message: Text(viewModel.error?.errorDescription ?? ""),
                dismissButton: .default(Text("确定"))
            )
        }
    }
}


struct ErrorView: View {
    let error: NetworkError
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.yellow)
            
            Text(error.errorDescription ?? "发生错误")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("重试", action: retryAction)
                .buttonStyle(.borderedProminent)
                .padding(.top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
