import wollok.game.*
import juego.*
import pantallas.*
import hud.*

class EstadoJuego {

    method ataque(dir) {}

    method especial() {}

    method mover(dir) {}

    method mejorarVida() {}

    method mejorarArma() {}

    method mejorarEnergia() {}

    method continuar() {}

    method elegirNoel() {}

    method elegirDangalf() {}

}

object estadoMenu inherits EstadoJuego() {
    
    override method continuar() {
        pantalla.seleccionPj()
        juego.estado(eleccionPersonaje)
    }
}

object eleccionPersonaje inherits EstadoJuego() {
    
    override method elegirNoel() {
        juego.elegirNoel()
        self.seguirAControles()
    }

    override method elegirDangalf() {
        juego.elegirDangalf()
        self.seguirAControles()
    }

     method seguirAControles() {
        pantalla.infoControles()
        juego.estado(infoControles)
    }
}

object infoControles inherits EstadoJuego() {
    
    override method continuar() {
        juego.estado(cargando)
        pantalla.iniciarCargando()
    }
}

object cargando inherits EstadoJuego() {

}

object jugando inherits EstadoJuego() {

    override method ataque(dir) {
        juego.jugador.ataque(dir)
    }

    override method mover(dir) {
        juego.jugador.mover(dir)
    }

    override method especial() {
        especial.tirarEspecial()
    }

}