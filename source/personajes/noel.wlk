import personaje.*
import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import armas.*
import proyectiles.*

object noel inherits Personaje(arma=pistola) {

    var property ultimaDir = derecha

    override method mover(dir) {
        super(dir)
        ultimaDir = dir
    }

    override method ataque(dir) {
        super(dir)
        ultimaDir = dir
    }

//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-noel.png"
    }

     override method municionImagen(){
        return "balas.png"
    }

//-----------ataque-movimiento--------------------------------

    override method imagenInicial(){
        return "noel-normal-arriba.png"
    }
   
    override method imagenAtaque(direccion) {
        return "noel-ataque-" + direccion.toString() + ".png"
    }

    override method imagenNormal(direccion) {
        return "noel-normal-" + direccion.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("tiro1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("noel-muerte-sonido.mp3").play()
    }

//------------hud-------------------------------------------

        override method sinMunicion(){
        game.sound("sin-balas.mp3").play()
    }

    method sonidoRecarga(){
        arma.sonidoRecarga()
    }

//---------------------arma--------------------------

    method cambiarAEscopeta() {
        arma = escopeta
    }

    method cambiarAPistola() {
        arma = pistola
    }

//-------------------especial------------------------


    override method lanzarEspecial() {
        const baston = new Baston(position=self.ultimaDir().siguientePosicion(position))
        game.addVisual(baston)
        baston.nuevoViaje(ultimaDir)
    }

}




