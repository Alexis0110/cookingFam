//
//  CatDogModel.swift
//  CatDogMVVM
//
//  Created by Miriam Föller-Nord on 26.12.22.
//
// This is the model: basic data structure and functionality here

import Foundation
struct Model {
// define properties and methods
    enum Pet:String { // The case are a dog or a cat?
        case 🐶
        case 🐱
    }

    var pet: Pet = .🐶 // The initial value is a dog
    
    mutating func switchPet() { // Function to switch between dog and cat
        if pet == .🐶 {
            pet = .🐱
        } else {
            pet = .🐶
        }
    }

}
