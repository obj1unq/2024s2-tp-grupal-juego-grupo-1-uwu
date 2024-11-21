import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import proyectiles.*

object noel {

    method disparar(direccion,posDada) {
        const balaNueva = new Bala(image="bala-1-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(direccion)
    }

    method especial() {
      //nada aún
    }

    method imagenInicial(){
        return "noelnuevo-normal-arriba.png"
    }

    method imagenAtaque(direccion) {
        return "noelnuevo-ataque-" + direccion.toString() + ".png"
    }

    method imagenNormal(direccion) {
        return "noelnuevo-normal-" + direccion.toString() + ".png"
    }

    method sonidoAtaque(){
        game.sound("tiro1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("noel-muerte-sonido.mp3").play()
    }

    method hudMunicion(){
        return "balas-"
    }

    method municionImagen(){
        return "balas.png"
    }
    method sinMunicion(dir){
        game.sound("sin-balas.mp3").play()
    }

    method sonidoRecarga(){
        game.sound("pistola-recarga.mp3").play()
    }

    method cura(numero){
        return "cura" + numero + "-noel.png"
    }
}