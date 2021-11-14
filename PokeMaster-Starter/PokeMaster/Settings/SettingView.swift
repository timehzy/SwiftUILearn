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
        .navigationTitle("设置")
    }
    
    var accountSection: some View {
        Section("账户") {
            Picker(selection: settingsBinding.accountBehavior) {
                ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            } label: {}
            .pickerStyle(.segmented)
            TextField("电子邮箱", text: settingsBinding.email)
            SecureField("密码", text: settingsBinding.password)
            if settings.accountBehavior == .register {
                SecureField("确认密码", text: settingsBinding.verifyPassword)
            }
            Button(settings.accountBehavior.text) {
                print("denglu")
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
