//
//  Model.swift
//  Miawouf
//
//  Created by Chr V on 03/11/2021.
//

import Foundation

struct Pet {
    enum Gender {
        case male, female
    }
    
    var name: String?
    var hasMajority: Bool
    var phone: String?
    var race: String?
    var gender: Gender
}
extension Pet {
    enum Status {
        case accepted
        case rejeted(String)
    }
    var status: Status {
        if name == nil || name == "" {
            return .rejeted("Vous n'avez pas indiqué votre nom !")
        }
        if phone == nil || phone == "" {
            return .rejeted("Vous n'avez pas indiqué votre téléphone !")
        }
        if race == nil || race == "" {
            return .rejeted("Quel est votre race ?")
        }
        if !hasMajority {
            return .rejeted("Les mineurs ne sont pas admis.")
        }
        return .accepted
    }
}
