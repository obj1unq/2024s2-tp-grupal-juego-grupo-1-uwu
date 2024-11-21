import hud.*
import wollok.game.*
import personajes.personaje.*
import juego.*
import posiciones.*



//---------------------------------Drops---------------------------------------

class Drop {
    var property position
    var property image
}



//---------------------------------Curas---------------------------------------
class Cura inherits Drop {
    const vidaDada

    method colisionPj() {
        puntosDeVida.curarse(vidaDada)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Monedas---------------------------------------

class Oro inherits Drop()  {
    const valor

    method colisionPj() {
        juego.jugador().obtenerOro(valor)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Municion---------------------------------------

class Balas inherits Drop(image = juego.jugador().visualAmmo()){

    method colisionPj() {
        juego.jugador().arma().recargar(6)
        game.removeVisual(self)
        managerItems.quitarItem(self)
        managerItems.restarBalasDeTablero()
    }
}


//---------------------------------Colisiones---------------------------------------

object muro  {

    var property position = game.at(8,8)
    var property image = "madera.png"
}

object municionActual {

    method position() {return game.at(6, game.height() - 1 )}

    method text() {return juego.jugador().arma().cargador().toString()}

    method colisionPj() {}

    method textColor() {return "FFFFFF"}

}

