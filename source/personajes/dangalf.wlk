import proyectiles.*
import wollok.game.*
import posiciones.*
import extras.*
import armas.*
import hud.*
import personajes.personaje.*

object dangalf inherits Personaje(arma=manosMagicas) {

//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-mago.png"
    }

    override method municionImagen(){
        return "potion.png"
    }

//-----------ataque-movimiento--------------------------------

    

    override method imagenInicial(){
        return "dangalfnuevo-normal-arriba.png"
    }

    override method imagenAtaque(dir) {
        return "dangalfnuevo-ataque-" + dir.toString() + ".png"
    }

    override method imagenNormal(dir) {
        return "dangalfnuevo-normal-" + dir.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("magia1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("wizard-death.mp3").play()
    }

//------------hud-------------------------------------------
    
    override method sinMunicion(){
        game.sound("mago-sin-municion.mp3").play()
    }

    method sonidoRecarga(){
        arma.sonidoRecarga()
    }

//-----------especial---------------------------------------

    override method lanzarEspecial() {
        self.dispararEspecialHacia(abajo)
        self.dispararEspecialHacia(arriba)
        self.dispararEspecialHacia(derecha)
        self.dispararEspecialHacia(izquierda)
    }

    method dispararEspecialHacia(direccion) {
        const rayo = new BolaEnergia(position=direccion.siguientePosicion(position))
        game.addVisual(rayo)
        rayo.nuevoViaje(direccion)
    }

}