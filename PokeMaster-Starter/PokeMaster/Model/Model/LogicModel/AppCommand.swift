//
//  AppCommand.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/15.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation
import Combine

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

protocol AppCommand {
    func execute(in store: Store)
}

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoginRequest(email: email, password: password)
            .publisher
            .sink { completion in
                if case .failure(let error) = completion {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            }
            .seal(in: token)
    }
}

struct LoadPokemonsCommand: AppCommand {
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadPokemonRequest.all
            .sink {
                if case .failure(let error) = $0 {
                    store.dispatch(.loadPokemonsDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: {
                store.dispatch(.loadPokemonsDone(result: .success($0)))
            }
            .seal(in: token)
    }
}
