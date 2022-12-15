//
//  UserSetting.swift
//  miniword
//
//  Created by 章珂 on 2022/6/9.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {

    @Published var fontSize: Double
    @Published var changeTime: Double
    @Published var fontColor: Color

    init(fontSize:Double,changeTime:Double,fontColor:Color) {
        self.fontSize = fontSize
        self.changeTime = changeTime
        self.fontColor = fontColor
    }
}
