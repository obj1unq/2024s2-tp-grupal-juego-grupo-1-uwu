import wollok.game.*
import personaje.*
import posiciones.*
import juego.*
import extras.*
import hud.*
import proyectiles.*

class Arma {

    var property cargador 
    const cadencia
    var estado = estadoAtacar 
    
    method quitarMunicion() {
        cargador -= 1
        managerItems.posiblesBalas(cargador)
    }

    method disparar(dir,pos) {
        juego.jugador().animacionAtaque(dir)
        self.quitarMunicion()
        self.cicloEstado()
    }

    method validarAtaque(){
        if (cargador == 0){
            juego.jugador().sinMunicion()
            self.error("")
        }
    }

    method gatillar(dir,pos) {
        estado.gatillar(dir,pos,self)
    }

    method cicloEstado() {
        estado = estadoEsperar
        game.schedule(cadencia, {estado = estadoAtacar})
    }

    method recargar(cant) {
        cargador += cant
    }

    method hudMunicion()
    method sonidoRecarga()
    method municionMaxima()
}


object pistola inherits Arma(cadencia=500,cargador=12) {


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

    override method municionMaxima(){
        return 12
    }
}

object escopeta inherits Arma(cadencia=800,cargador=6) {

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

    override method municionMaxima(){
        return 6
    }
}

object manosMagicas inherits Arma(cadencia=800,cargador=12) {

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