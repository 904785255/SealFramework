//
//  UserViewModel.swift
//  OnePartner
//
//  Created by bin sun on 2025/7/4.
//

import Foundation
import Combine
import NetworkingManger
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var error: NetworkError?
    
//    private let apiService = ApiService()
    
    func loadUsers() {
        isLoading = true
        error = nil
        
//        apiService.fetch([User].self, string: "")
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                self?.isLoading = false
//                if case .failure(let error) = completion {
//                    self?.error = error
//                }
//            }, receiveValue: { [weak self] users in
//                self?.users = users
//            })
//            .store(in: &cancellables)
    }
    
    func refreshUsers() {
        loadUsers()
    }
}
