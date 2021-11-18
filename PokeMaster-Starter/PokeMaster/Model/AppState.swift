//
//  AppState.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/14.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
}

extension AppState {
    struct PokemonList {
        @FileStorage(directory: .cachesDirectory, fileName: "pokemons")
        var pokemons: [Int : PokemonViewModel]?
        var loadingPokemons = false
        
        var allPokemonsByID: [PokemonViewModel] {
            guard let pokemons = pokemons?.values else { return [] }
            return pokemons.sorted { $0.id < $1.id }
        }
    }
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        enum AccountBehavior: CaseIterable, Comparable {
            case register, login
        }
        
        @FileStorage(directory: .documentDirectory, fileName: "user")
        var loginUser: User?

        var showEnglishName = true
        @UserDefault(key: "sorting", defalutValue: Sorting.id)
        var sorting: Sorting
        var showFavoriteOnly = false
        @UserDefault(key: "loginRequesting", defalutValue: false)
        var loginRequesting: Bool
        var loginError: AppError?
        var isLoginError: Bool = false
        
        class AccountChecker {
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            @Published var accountBehavior = AccountBehavior.login
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email
                    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        switch (validEmail, canSkip) {
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest(email: self.email).publisher.eraseToAnyPublisher()
                        case (true ,true):
                            return Just(true).eraseToAnyPublisher()
                        }
                    }
                let emailLocalValid = $email.map{ $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map{ $0 == .login }
                return Publishers.CombineLatest3(remoteVerify, emailLocalValid, canSkipRemoteVerify)
                    .map{ $0 && ($1 || $2) }
                    .eraseToAnyPublisher()
            }
        }
        
        var checker = AccountChecker()
        var isEmailValid = false
    }
}

extension AppState.Settings.Sorting {
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}

extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}
