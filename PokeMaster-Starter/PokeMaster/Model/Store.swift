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
            appState.settings.email = ""
        case .accountBehaviorDone(result: let result):
            appState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.password = ""
                appState.settings.verifyPassword = ""
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
        }
        return (appState, appCommand)
    }
}
