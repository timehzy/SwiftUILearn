//
//  Store.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/14.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    var disposeBag = [AnyCancellable]()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        appState.settings.checker.isEmailValid
            .sink { self.dispatch(.emailValid(valid: $0)) }
            .store(in: &disposeBag)
        appState.settings.checker.isPasswordVerified
            .sink { self.dispatch(.passwordVerify(verified: $0)) }
            .store(in: &disposeBag)
        appState.settings.checker.isRegisterValid
            .sink { self.dispatch(.registerValid(valid: $0)) }
            .store(in: &disposeBag)
    }
    
    func dispatch(_ action: AppAction) {
#if DEBUG
        print("[ACTION]:\(action)")
#endif
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            #if DEBUG
            print("[COMMAND]:\(command)")
            #endif
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        switch action {
        case .login(let email, let password):
            guard !appState.settings.loginRequesting else { break }
            appState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .logout:
            appState.settings.loginUser = nil
            appState.settings.checker.email = ""
        case .accountBehaviorDone(result: let result):
            appState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.checker.password = ""
                appState.settings.checker.verifyPassword = ""
                appState.settings.loginUser = user
                appState.settings.isLoginError = false
            case .failure(let error):
                appState.settings.loginError = error
                appState.settings.isLoginError = true
            }
        case .emailValid(valid: let valid):
            appState.settings.isEmailValid = valid
        case .loadPokemons:
            guard !appState.pokemonList.loadingPokemons else { break }
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
        case .loadPokemonsDone(result: let result):
            appState.pokemonList.loadingPokemons = false
            switch result {
            case .success(let models):
                appState.pokemonList.pokemons = Dictionary(uniqueKeysWithValues: models.map{ ($0.id, $0) })
            case .failure(let error):
                print(error)
            }
        case .passwordVerify(verified: let verified):
            appState.settings.isPasswordVerified = verified
        case .registerValid(valid: let valid):
            appState.settings.isRegisterValid = valid
        }
        return (appState, appCommand)
    }
}
