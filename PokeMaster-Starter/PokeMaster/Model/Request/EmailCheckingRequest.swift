//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/17.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String
    
    var publisher: AnyPublisher<Bool, Never> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if email.lowercased() == "timehzy@gmail.com" {
                    promise(.success(true))
                } else {
                    promise(.success(false))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
