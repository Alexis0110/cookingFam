//
//  ContentView.swift
//  BatteryLevel
//
//  Created by Miriam Föller-Nord on 07.01.23.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject private var batteryViewModel = BatteryViewModel()

    var body: some View {
        VStack {

            BatteryView()
            HStack {
                Text("Battery state: ")
                Text("\(batteryViewModel.batteryStateDescription)")
                    .foregroundColor(self.batteryViewModel.batteryStateColor)

            }
            .font(Font.body.bold())
        }
        .padding()
        .preferredColorScheme(.dark)
        
    }
}

struct BatteryView: View {
    @ObservedObject private var batteryViewModel = BatteryViewModel()
    
    var body: some View {
        HStack {
            Text("\(batteryViewModel.batteryLevel) %")
                .foregroundColor(self.batteryViewModel.batteryStateColor)
                .font(Font.title.bold())

            ZStack{
                // Battery Image with load level
                Image(systemName: "battery.0")
                    .resizable()
                    .scaledToFit()
                    .font(.headline.weight(.ultraLight))
                    .background(Rectangle()
                        .fill(batteryViewModel.batteryStateColor)
                        .scaleEffect(x:CGFloat(self.batteryViewModel.batteryLevelFloat), y:1, anchor:.leading))
                    .mask(
                        Image(systemName: "battery.100")
                            .resizable()
                            .scaledToFit()
                            .font(.headline.weight(.ultraLight))
                    )
                    .frame(width: 200)
                    .padding()
                
                // Bolt Image, if state is charging
                Image(systemName: "bolt.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .font(.headline.weight(.ultraLight))
                    .opacity(self.batteryViewModel.isCharging ? 1 : 0)
                Image(systemName: "bolt")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.black)
                    .font(.headline.weight(.ultraLight))
                    .opacity(self.batteryViewModel.isCharging ? 1 : 0)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
