//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func suma(valor: Int, sumaFunc : (Int) -> Int) -> Int {
    return sumaFunc(valor)
}


let closure = {(valor: Int) -> Int in return valor + 5}

let closure2 = {(valor: Int) -> Int in print("No suma");return 0}

suma(valor: 10, sumaFunc: closure)
