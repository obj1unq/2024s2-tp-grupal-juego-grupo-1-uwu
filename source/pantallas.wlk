object pantalla {
    method position() = game.at(0,0)
    var property image = "Menu.png"

    method seleccionPj() {
        image = "Seleccion-de--Personaje.png"
    }

    method infoControles() {
        image = "Controles.png"
    }

    method iniciarCargando() {
        image = "Cargando-1.png"
        game.schedule(500, {image = "Cargando-2.png"})
        game.schedule(1000, {image = "Cargando-3.png"})
        game.schedule(4000,{self.abandonarCargando()})
    }

    method abandonarCargando() {
        image = "Cargando-2.png"
        game.schedule(500, {image = "Cargando-1.png"})
        game.schedule(1000, {game.removeVisual(self)})
    }

}

object fondo {

}

object hudVisible {

}
