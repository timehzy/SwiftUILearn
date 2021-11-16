//
//  AppState.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/14.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation

struct AppState {
    var settings = Settings()
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
        var email = ""
        var password = ""
        var accountBehavior = AccountBehavior.login
        var verifyPassword = ""
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        var loginRequesting = false
        var loginError: AppError?
        var isLoginError: Bool = false
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
