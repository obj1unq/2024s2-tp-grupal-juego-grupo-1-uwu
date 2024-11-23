import personaje.*
import wollok.game.*
import posiciones.*
import armas.*
import proyectiles.*

object noel inherits Personaje(arma=pistola) {

    const property armas = [doblePistola, escopeta, dobleEscopeta]
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

    override method visualAmmo(){
        return "variasBalas.png"
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

    //Es igual en ambos pj, hay que meterlo en personaje
    method mejorarArma(){
        if(not armas.isEmpty()){
            arma = armas.first()
            armas.remove(arma)
        }
    }
    
    method precioSiguienteArma(){
        return armas.first().precio()
    }
    
    method cambiarAEscopeta() {
        arma = escopeta
    }

    method cambiarAPistola() {
        arma = pistola
    }

//-------------------especial------------------------


    override method lanzarEspecial() {
        const baston = new Baston(position=self.ultimaDir().siguientePosicion(position), image="baston-"+self.ultimaDir()+".png")
        game.addVisual(baston)
        baston.nuevoViaje(ultimaDir)
    }

}




