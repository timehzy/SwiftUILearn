//
//  SettingView.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/9.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import SwiftUI
import Combine

struct SettingView: View {
    @EnvironmentObject var store: Store
    
    // 会由用户通过UI修改的值需要binding
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    // 不会由用户修改的值无需binding
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var body: some View {
        Form {
            accountSection
            optionsSection
            actinoSection
        }
        .alert(settings.loginError?.localizedDescription ?? "登录失败", isPresented: settingsBinding.isLoginError, actions: {})
        .navigationTitle("设置")

    }
    
    var accountSection: some View {
        Section("账户") {
            if let user = settings.loginUser {
                Text(user.email)
                Button("登出") {
                    store.dispatch(.logout)
                }
            } else {
                Picker(selection: settingsBinding.checker.accountBehavior) {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                } label: {}
                .pickerStyle(.segmented)
                TextField("电子邮箱", text: settingsBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .black : .red)
                SecureField("密码", text: settingsBinding.checker.password)
                if settings.checker.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.checker.verifyPassword)
                }
                if settings.loginRequesting {
                    Text("登录中……")
                } else {
                    Button(settings.checker.accountBehavior.text) {
                        store.dispatch(.login(email: settings.checker.email, password: settings.checker.password))
                    }                    
                }
            }
        }
    }
    
    var optionsSection: some View {
        Section("选项") {
            Toggle("显示英文名", isOn: settingsBinding.showEnglishName)
            Picker("排序方式", selection: settingsBinding.sorting) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            
            Toggle("只显示收藏", isOn: settingsBinding.showFavoriteOnly)
        }
    }
    
    var actinoSection: some View {
        Section {
            Button(role: .destructive) {
                
            } label: {
                Text("清空缓存")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(Store())
    }
}
