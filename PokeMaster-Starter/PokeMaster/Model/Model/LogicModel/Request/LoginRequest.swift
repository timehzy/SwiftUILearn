//
//  LoginRequest.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/15.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

struct LoginRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                if self.password == "123" {
                    let user = User(email: email, favoritePokemonIDs: [])
                    promise(.success(user))
                } else {
                    promise(.failure(.passwordWrong))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
