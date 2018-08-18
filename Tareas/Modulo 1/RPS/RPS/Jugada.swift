//
//  Jugada.swift
//  RPS
//
//  Created by Ricardo Yepez on 11/08/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import Foundation

import GameplayKit

let randomChoice = GKRandomDistribution (lowestValue: 0, highestValue: 2)

enum Resultado {
    case gana,pierde,empata
}

func randomSign () -> Jugada {
    let sign = randomChoice.nextInt()
    if sign == 0 {
        return .piedra
    }else if sign == 1{
        return .papel
    }else{
        return .tijera
    }
}


enum Jugada{
    case piedra,papel,tijera
    
    func vence(otraJugada:Jugada) -> Resultado{
        switch self {
        case .papel:
            return vencePapel(otraJugada:otraJugada)
        case .piedra:
            return vencePiedra(otraJugada:otraJugada)
        case .tijera:
            return venceTijera(otraJugada:otraJugada)
        }
    }
    
    func vencePapel(otraJugada:Jugada) -> Resultado{
        if otraJugada == .piedra {
            return .gana;
        }else if otraJugada == .tijera{
            return .pierde;
        }
        return .empata
    }
    func vencePiedra(otraJugada:Jugada) -> Resultado{
        if otraJugada == .tijera {
            return .gana;
        }else if otraJugada == .papel{
            return .pierde;
        }
        return .empata

    }
    func venceTijera(otraJugada:Jugada) -> Resultado{
        if otraJugada == .papel {
            return .gana;
        }else if otraJugada == .piedra{
            return .pierde;
        }
        return .empata
        
        
    }
}


