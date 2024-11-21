import proyectiles.*
import wollok.game.*
import posiciones.*
import extras.*
import hud.*

object dangalf {

    method disparar(direccion, posDada) {
        const bolaNueva = new BolaDeFuego(image="bola-1-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
        game.addVisual(bolaNueva)
        bolaNueva.nuevoViaje(direccion)
    }

    method dispararEspecial(direccion, posDada) {
        const rayo = new Especial(image="rayoGrande.png", position=direccion.siguientePosicion(posDada))
        game.addVisual(rayo)
        rayo.nuevoViaje(direccion)
    }

    method imagenInicial(){
        return "dangalf-normal-arriba.png"
    }

    method imagenAtaque(dir) {
        return "dangalf-ataque-" + dir.toString() + ".png"
    }

    method imagenNormal(dir) {
        return "dangalf-normal-" + dir.toString() + ".png"
    }

    method especial(){}

    method sonidoAtaque(){
        game.sound("magia1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("wizard-death.mp3").play()
    }

    method hudMunicion(){
        return "mana-"
    }
    
    method municionImagen(){
        return "potion.png"
    }
    method sinMunicion(dir){
        game.sound("mago-sin-municion.mp3").play()
    }

    method sonidoRecarga(){
        game.sound("mana.mp3").play()
    }

    method cura(numero){
        return "cura" + numero + "-mago.png"
    }
}