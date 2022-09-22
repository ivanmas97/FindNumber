//
//  SettingsGame.swift
//  FindNumber
//
//  Created by Ivan Maslov on 22.09.2022.
//

import Foundation
enum KeysUserDefaults {
    static let settingsGame = "settingsGame"
}

struct SettingsGame: Codable {
    var timerSelected: Bool
    var timeForGame: Int
}

class Settings {
    
    static var shared = Settings()
    private let defaultSettings = SettingsGame(timerSelected: true, timeForGame: 30)
    var currentSettings: SettingsGame {
        
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
                }
                return defaultSettings
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
            }
        }
    }
    
    func resetSettings() {
        currentSettings = defaultSettings
    }
}
