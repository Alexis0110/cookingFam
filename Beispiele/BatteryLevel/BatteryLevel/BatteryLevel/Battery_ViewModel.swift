//
//  Battery_Class.swift
//  BatteryLevel
//
//  Created by Miriam Föller-Nord on 04.05.23.
//
import SwiftUI
import Foundation
class BatteryViewModel: ObservableObject {
    @Published var batteryLevel: Int = 0
    @Published var batteryLevelFloat: Float = 0
    @Published var batteryStateDescription: String = ""
    @Published var batteryStateColor: Color = .gray
    @Published var isCharging: Bool = false

    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        self.batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        self.batteryLevelFloat = UIDevice.current.batteryLevel < 0 ? 0 : UIDevice.current.batteryLevel
        setBatteryState()
        
        // Notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange(notification:)), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange(notification:)), name: UIDevice.batteryStateDidChangeNotification, object: nil)
    }
    // Needs Objective-C Functions:
        @objc func batteryLevelDidChange(notification: Notification) {
            self.batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        }
        
        @objc func batteryStateDidChange(notification: Notification) {
            setBatteryState()
        }
       
    
    private func setBatteryState() {
        let batteryState = UIDevice.current.batteryState
        self.batteryStateDescription = getBatteryDescription(for: batteryState)
        self.batteryStateColor = getBatteryColor(for: batteryState)
        self.isCharging = UIDevice.current.batteryState == .charging ? true : false
    }
    
    private func getBatteryColor (for state: UIDevice.BatteryState) -> Color {
        switch state {
        case .unknown:
            return .gray
        case .unplugged:
            if self.batteryLevel < 10 {
                return .red
            } else if self.batteryLevel < 30 {
                return .yellow
            } else {
                return .green
            }
        case .charging:
            return .green
        case .full:
            return .blue
        @unknown default:
            return .gray
        }
    }
    private func getBatteryDescription(for state: UIDevice.BatteryState) -> String {
            switch state {
            case .unplugged:
                return "On battery power"
            case .charging:
                return "Charging"
            case .full:
                return "Full charged"
            case .unknown:
                return "Unknown"
            @unknown default:
                return "Unknown"
            }
        }
}
