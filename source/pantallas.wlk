import niveles.*
import wollok.game.*

object pantalla {
    method position() = game.at(0,0)
    var property image = "Menu.png"

    method seleccionPj() {
        image = "Seleccion-de--Personaje.png"
    }

    method infoControles() {
        image = "Controles.png"
    }

    method animacionCargando() {
        image = "Cargando-3.png"
        game.schedule(3000,{self.abandonarCargando()})
    }

    method abandonarCargando() {
        nivelManager.iniciarSigNivel()
        game.removeVisual(self)
    }

}

object fondo {

}

object hudVisible {

}
