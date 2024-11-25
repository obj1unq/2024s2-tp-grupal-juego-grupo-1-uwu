import wollok.game.*
import personajes.personaje.*
import personajes.noel.*
import personajes.dangalf.*
import enemigos.*
import extras.*
import posiciones.*
import sonidos.*
import hud.*
import managers.*
import tienda.*
import estadosJuego.*
import pantallas.*

object menu {
    /*
    var property image =
    var property position = game.at 
    */
}

object juego {

    var property estado = estadoMenu 
    var property jugador = noel
    var property musicaActual = musicaMenu


    method elegirNoel() {
        jugador = noel
    }

    method elegirDangalf() {
        jugador = dangalf
    }

    method inicio() {
        self.iniciarSonidoMenu()
        estado = estadoMenu
        game.addVisual(pantalla)
    }

    method iniciarSonidoMenu() {
        musicaActual.play()
    }

    method frenarSonidoMenu() {
        musicaActual.stop()
    }

    method teclas() {
        //ataque
        keyboard.left().onPressDo({estado.ataque(izquierda)})
        keyboard.right().onPressDo({estado.ataque(derecha)})
        keyboard.up().onPressDo({estado.ataque(arriba)})
        keyboard.down().onPressDo({estado.ataque(abajo)})
        keyboard.q().onPressDo({estado.especial()})
        //movimiento
        keyboard.w().onPressDo({estado.mover(arriba)})
	    keyboard.a().onPressDo({estado.mover(izquierda)})
	    keyboard.s().onPressDo({estado.mover(abajo)})
	    keyboard.d().onPressDo({estado.mover(derecha)})
        //Tienda
        keyboard.j().onPressDo({estado.mejorarVida()})
        keyboard.k().onPressDo({estado.mejorarArma()})
        keyboard.l().onPressDo({estado.mejorarEnergia()})
        //menu
        keyboard.enter().onPressDo({estado.continuar()})
        keyboard.o().onPressDo({estado.elegirNoel()})
        keyboard.p().onPressDo({estado.elegirDangalf()})
    }

    method hud() {

        game.addVisual(municionActual)
        game.addVisual(barra)
        game.addVisual(timer)
        game.addVisual(puntosDeVida)
        game.addVisual(hudBalas)
        //game.addVisual(oroObtenido)
        game.addVisual(barraDeEnergia)
        game.addVisual(jugador)
        game.addVisual(cadenciaHud)
        game.onTick(1000, "hud", {self.actualizarHud()})
    }

    method tablero() {
        game.title("desvariados") 
        game.width(20)
        game.height(15)
        game.cellSize(45)
        //game.ground("pisonuevo-stage1.png")

        
        // para testear las clases vamos a colocar teclas para hacer aparecer cada una
        // mas adelante sus spawns van a estar decididos por otros eventos y no estas teclas
        keyboard.z().onPressDo({managerZombie.spawnearZ(generadorZombie.zombieComun(generadorZombie.posicionInicial()))})
        keyboard.x().onPressDo({managerZombie.spawnearZ(generadorZombie.zombiePerro(generadorZombie.posicionInicial()))})
        keyboard.c().onPressDo({managerZombie.spawnearZ(generadorZombie.zombieTanque(generadorZombie.posicionInicial()))})
        keyboard.v().onPressDo({managerZombie.spawnearZ(generadorZombie.zombieThrower(generadorZombie.posicionInicial()))})
        keyboard.b().onPressDo({managerItems.spawnearCura(0.randomUpTo(3).round().max(1),tablero.posicionRandom())})
        keyboard.n().onPressDo({managerItems.spawnearOro(0.randomUpTo(3).round().max(1),tablero.posicionRandom())})
        keyboard.m().onPressDo({managerItems.spawnearMunicionRandom()})
        
        //game.onTick(15000, "drops", {managerItems.generarDropRandom()})

        // testeo spawneo zombies
        //game.onTick(3000, "generarZombiesRandom", {managerZombie.generarZombieAleatorio(randomizadorZombies.posicionAleatoria())})

    }

    method actualizarHud(){
        barraDeEnergia.recargarEnergia()
        timer.tick()
    }

    method sonido() {

        const sonidoFondo = game.sound("echo-in-the-night.mp3")
        keyboard.y().onPressDo({sonidoFondo.volume(0.6)})
        keyboard.u().onPressDo({sonidoFondo.volume(0.3)})
        keyboard.i().onPressDo({sonidoFondo.volume(0)})
        sonidoFondo.shouldLoop(true)
        //game.schedule(003, { sonidoFondo.play()} )
    }

    method persecucion() {
        game.onTick(650,"persecucionGame",{managerZombie.zombies().forEach({z => z.perseguirAJugador()})})
    }

        // -------------niveles-------------------------------

    method configurarNivel(nivel){
        
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