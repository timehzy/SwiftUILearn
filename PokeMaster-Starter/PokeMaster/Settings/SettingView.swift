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
    
    @ObservedObject var settings = Settings()
    
    var body: some View {
        NavigationView {
            Form {
                accountSection
                optionsSection
                actinoSection
            }
            .navigationTitle("设置")
        }
    }
    
    var accountSection: some View {
        Section("账户") {
            Picker(selection: $settings.accountBehavior) {
                ForEach(Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            } label: {}
            .pickerStyle(.segmented)
            TextField("电子邮箱", text: $settings.email)
            SecureField("密码", text: $settings.password)
            if settings.accountBehavior == .register {
                SecureField("确认密码", text: $settings.verifyPassword)
            }
            Button(settings.accountBehavior.text) {
                print("denglu")
            }
        }
    }
    
    var optionsSection: some View {
        Section("选项") {
            Toggle("显示英文名", isOn: $settings.showEnglishName)
            Picker(selection: $settings.sorting) {
                ForEach(Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            } label: {
                Text("排序方式")
            }
            Toggle("只显示收藏", isOn: $settings.showFavoriteOnly)
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
        SettingView()
    }
}
