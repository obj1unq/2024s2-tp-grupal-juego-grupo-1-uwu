import nivelManager.*
import juego.*
import wollok.game.*
import stats.*
import tienda.*

object pantalla {
    method position() = game.at(0,0)
    var property image = "Menu.png"

    method fin() {
        game.addVisual(self)
        image = "pantalla-victoria.png"
    }

    method seleccionPj() {
        image = "Seleccion-de--Personaje.png"
    }

    method infoControles() {
        image = "Controles.png"
    }

    method animacionInicio() {
        image = "Cargando-3.png"
        game.schedule(1000,{self.abandonarCargando()})
    }

    method animacionCargando() {
        game.addVisual(self)
        image = "Cargando-1.png"
        game.schedule(400, {image="Cargando-2.png"})
        game.schedule(800, {self.limpiar()})
    }

    method limpiar() {
        game.allVisuals().forEach({v => game.removeVisual(v)})
        game.addVisual(self)
        image = "Cargando-3.png"
        self.abandonarCargando()
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
        game.addVisual(especial)
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
    var property image = ""

    method visualizarCon(img) {
        image = img 
        game.addVisual(self)
    }
}

object mercadoVisible{
    method dibujar(){
        game.addVisual(mejoraDeArma)
        game.addVisual(mejoraDeEnergia)
        game.addVisual(mejoraDeVida)
        game.addVisual(tienda)
        // game.addVisual(self) Numeros
        // game.addVisual(self) Numeros
        // game.addVisual(self) Numeros
    }
}