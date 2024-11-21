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

object managerCuras {
    const vida = [20, 40, 80]

    method cura(numero, position) {
        return new Cura(image = juego.jugador().visualHealth(numero)
                , vidaDada = self.vida(numero), position = position)
    }

    method vida(numero) {
        return vida.get(numero - 1)
    }
}

object managerMonedas {
    const oro = [10, 30, 50]
    
    method monedas(numero, position) {
        return new Oro(image = "oro" + numero + ".png",
                valor = self.oro(numero), position = position)
    }

    method oro(numero) {
        return oro.get(numero - 1)
    }
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

