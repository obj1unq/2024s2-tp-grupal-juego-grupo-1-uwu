import wollok.game.*
import personajes.personaje.*
import enemigos.*
import extras.*
import posiciones.*
import sonidos.*
import hud.*
import managers.*


object juego {

    method visuals() {
        game.addVisual(municionActual)
        game.addVisual(barra)
        game.addVisual(timer)
        managerVisual.agregarVisual(personaje)
        game.addVisual(puntosDeVida)
        game.addVisual(cargador)
        game.addVisual(oroObtenido)
        game.addVisual(barraDeEnergia)
        
    }

    method ataque() {
        keyboard.left().onPressDo({personaje.ataque(izquierda)})
        keyboard.right().onPressDo({personaje.ataque(derecha)})
        keyboard.up().onPressDo({personaje.ataque(arriba)})
        keyboard.down().onPressDo({personaje.ataque(abajo)})
        // Espacial
        keyboard.space().onPressDo({personaje.especial()})
    }

    method movimiento() {
        keyboard.w().onPressDo({personaje.mover(arriba)})
	    keyboard.a().onPressDo({personaje.mover(izquierda)})
	    keyboard.s().onPressDo({personaje.mover(abajo)})
	    keyboard.d().onPressDo({personaje.mover(derecha)})
    }

    method tablero() {
        game.title("desvariados") 
        game.width(17)
        game.height(17)
        game.cellSize(45)
        game.ground("pisonuevo-stage1.png")


        keyboard.z().onPressDo({managerZombie.activarODesactivarGeneracionAleatoria()})
        keyboard.b().onPressDo({managerItems.spawnearCura(1)})
        keyboard.n().onPressDo({managerItems.spawnearOro(1)})
        keyboard.m().onPressDo({managerItems.spawnearMunicionRandom()})
        game.onTick(1000, "timer", {timer.tick()})
        game.onTick(500, "energia", {barraDeEnergia.recargarEnergia()})

        //game.onTick(3000, "generarZombiesRandom", {managerZombie.generarZombieAleatorio(randomizadorZombies.posicionAleatoria())})


    }

    method sonido() {

        const sonidoFondo = game.sound("echo-in-the-night.mp3")
        keyboard.y().onPressDo({sonidoFondo.volume(0.6)})
        keyboard.u().onPressDo({sonidoFondo.volume(0.3)})
        keyboard.i().onPressDo({sonidoFondo.volume(0)})
        sonidoFondo.shouldLoop(true)
        game.schedule(003, { sonidoFondo.play()} )
    }



    method colisiones() {
        game.onCollideDo(personaje, {objeto => objeto.colisionPj()})
    }

/*
    method pausa() {
        keyboard.space().onPressDo({self.pausarTodo()})
    }

    method pausarTodo() {
        var presionado = 0

        if (presionado == 0) {
            presionado = 1
            personaje.pausarse()
            game.removeTickEvent("persecucion")
            game.removeTickEvent("timer")
        } else {
            presionado = 0
            game.onTick(1000, "timer", {timer.tick()})
            game.onTick(800, "persecucion", {zombie.perseguirAPersonaje()})
            personaje.vivo()
        }
    }
*/
}