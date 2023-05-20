//
//  ViewModel.swift
//  CatDogMVVM
//
//  Created by Miriam Föller-Nord on 26.12.22.
//
// ViewModel - this is the link between view and model

import Foundation
import SwiftUI
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel:ObservableObject{
        /*
         With adding @Published to the Model, the ViewModel (@ObservableObject) can publishes the change in the model to the world as soon as there is a change in it.
         */
        
        @Published var model:Model = Model()
        @Published var isUnlocked = false
        
        var pet: String {               // computed property
            return model.pet.rawValue
        }
        
        func switchPet() {
            model.switchPet()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock."  // this is to use TouchID
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
                       Task { @MainActor in
                            self.isUnlocked = true
                       }
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
