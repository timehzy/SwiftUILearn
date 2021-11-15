//
//  AppError.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/15.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }
    case passwordWrong
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密码错误"
        }
    }
}
