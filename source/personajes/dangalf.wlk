import proyectiles.*
import wollok.game.*
import posiciones.*
import armas.*
import personaje.*

object dangalf inherits Personaje(arma=manosMagicas) {

    const armas = [tresManos]
//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-mago.png"
    }

    override method visualAmmo(){
        return "potion.png"
    }

//-----------ataque-movimiento--------------------------------

    

    override method imagenInicial(){
        return "dangalf-" + arma.toString() + "-normal-abajo.png"
    }

    override method imagenAtaque(dir) {
        return "dangalf-" + arma.toString() + "-ataque-" + dir.toString() + ".png"
    }

    override method imagenNormal(dir) {
        return "dangalf-" + arma.toString() + "-normal-" + dir.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("magia1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("wizard-death.mp3").play()
    }

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