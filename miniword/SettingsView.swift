//
//  SettingsView.swift
//  words
//
//  Created by 章珂 on 2022/6/5.
//

import Foundation
import SwiftUI


struct SettingsView: View {
    var body: some View {
        TabView {
            ProfileSettingsView()
                .tabItem {
                    Label("关于", systemImage: "person.crop.circle")
                }
            
            AppearanceSettingsView()
                .tabItem {
                    Label("反馈", systemImage: "paintpalette")
                }
            
            PrivacySettingsView()
                .tabItem {
                    Label("赞助", systemImage: "hand.raised")
                }
        }
        .frame(width: 450, height: 250)
        .frame(width: 450, height: 250)
    }
}



struct ProfileSettingsView: View {
    @EnvironmentObject private var userSettings: UserSettings
   var body: some View {
       Text("希望这个工具对你有用！")
           .font(.title)
   }
}


struct AppearanceSettingsView: View {
   var body: some View {
       Text("有问题可以发送邮件到 450639889@qq.com")
           .font(.title)
   }
}


struct PrivacySettingsView: View {
   var body: some View {
       HStack{
           Image("wechat")
               .resizable()
               .aspectRatio(contentMode: .fit)
       }
   }
}
