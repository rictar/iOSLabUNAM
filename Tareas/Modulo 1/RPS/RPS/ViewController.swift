//
//  ViewController.swift
//  RPS
//
//  Created by Ricardo Yepez on 11/08/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var estadoJuego: UILabel!
    @IBOutlet weak var piedraBoton: UIButton!
    @IBOutlet weak var papelBoton: UIButton!
    @IBOutlet weak var tijeraBoton: UIButton!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var reiniciarBoton: UIButton!
    
    
    @IBAction func jugar(_ sender: UIButton) {
        var jugadaUsuario : Jugada
        
        if sender.titleLabel?.tag ?? 0 == 1 {
            jugadaUsuario = .piedra
            papelBoton.isHidden = true
            tijeraBoton.isHidden = true
        }else if sender.titleLabel?.tag ?? 0 == 2 {
            jugadaUsuario = .papel
            piedraBoton.isHidden = true
            tijeraBoton.isHidden = true
        }else {
            jugadaUsuario = .tijera
            papelBoton.isHidden = true
            piedraBoton.isHidden = true
        }
        
        let jugadaCPU = randomSign()
        
        
        switch jugadaCPU {
        case .piedra:
            cpuLabel.text = "👊"
        case .papel:
            cpuLabel.text = "✋"
        case .tijera:
            cpuLabel.text = "🖖"
        
        }
        
        
        let resultadoJuego = jugadaUsuario.vence(otraJugada:jugadaCPU)
        
        
        
        switch resultadoJuego {
        case .empata:
            estadoJuego.text = "Empate!! 😑"
            view.backgroundColor = UIColor.blue
        case .gana:
            estadoJuego.text = "Tu ganas!! 😡"
            view.backgroundColor = UIColor.green
        case .pierde:
            estadoJuego.text = "Looser 😛"
            view.backgroundColor = UIColor.red
        
        }
        
        reiniciarBoton.isHidden = false
        
    }
    
    @IBAction func reiniciarJuego(_ sender: UIButton) {
        estadoJuego.text = "Piedra,Papel o Tijera?"
        papelBoton.isHidden = false
        piedraBoton.isHidden = false
        tijeraBoton.isHidden = false
        sender.isHidden = true
        view.backgroundColor = UIColor.darkGray
        cpuLabel.text = "👽"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        piedraBoton.titleLabel?.tag = 1
        papelBoton.titleLabel?.tag = 2
        tijeraBoton.titleLabel?.tag = 3
        reiniciarBoton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

