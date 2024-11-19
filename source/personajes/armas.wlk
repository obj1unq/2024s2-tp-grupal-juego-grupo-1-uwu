import wollok.game.*
import personaje.*
import posiciones.*
import juego.*
import extras.*
import hud.*
import proyectiles.*

class Arma {

    const cadencia
    var estado = estadoAtacar 
    
    method disparar(dir,pos) {
        juego.jugador().animacionAtaque(dir)
        cargador.quitarMunicion(1)
        self.cicloEstado()
    }

    method gatillar(dir,pos) {
        estado.gatillar(dir,pos,self)
    }

    method cicloEstado() {
        estado = estadoEsperar
        game.schedule(cadencia, {estado = estadoAtacar})
    }

    method hudMunicion()
    method sonidoRecarga()
    method municion()
    method municionMaxima()
}


object pistola inherits Arma(cadencia=500) {

    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new Bala(image="bala-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "balas-"
    }

    override method sonidoRecarga() {
        game.sound("pistola-recarga.mp3").play() 
    }

    override method municion(){
        return 12
    }

    override method municionMaxima(){
        return 12
    }
}

object escopeta inherits Arma(cadencia=800) {

    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new BalaEscopeta(image="balaEscopeta-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "cartucho-"
    }

    override method sonidoRecarga() {
        game.sound("pistola-recarga.mp3").play() 
    }

    override method municion(){
        return 6
    }

    override method municionMaxima(){
        return 6
    }
}

object manosMagicas inherits Arma(cadencia=800) {

    override method disparar(dir,pos) {
        super(dir,pos)
        const bolaNueva = new BolaDeFuego(image="bola-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(bolaNueva)
        bolaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "mana-"
    }

    override method sonidoRecarga(){
        game.sound("mana.mp3").play()
    }

    override method municion(){
        return 12 
    }

    override method municionMaxima(){
        return 12
    }
}

object estadoAtacar {
    method gatillar(dir,pos,arma) {
        arma.disparar(dir,pos)
    }
}

object estadoEsperar {
    method gatillar(dir,pos,arma) {}
}