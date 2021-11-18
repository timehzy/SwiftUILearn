//
//  AppAction.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/15.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case logout
    case accountBehaviorDone(result: Result<User, AppError>)
    case emailValid(valid: Bool)
    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
}
