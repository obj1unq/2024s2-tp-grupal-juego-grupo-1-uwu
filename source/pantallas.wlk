import nivelManager.*
import juego.*
import wollok.game.*
import stats.*

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

object hudVisible {

    method dibujar() {
        game.addVisual(municionActual)
        game.addVisual(barra)
        game.addVisual(timer)
        game.addVisual(puntosDeVida)
        game.addVisual(hudBalas)
        game.addVisual(barraDeEnergia)
        game.addVisual(cadenciaHud)
        game.addVisual(juego.jugador())
        game.onTick(1000, "hud", {self.actualizarHud()})
    }

    method actualizarHud() {
        barraDeEnergia.recargarEnergia()
        timer.tick()
    }

}

object suelo {
    var property position = game.at(0,0)
    var property image = "empty"

    method visualizarCon(img) {
        image = img 
        game.addVisual(self)
    }
}