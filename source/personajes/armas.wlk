import wollok.game.*
import juego.*
import proyectiles.*
import managers.*

class Arma {

    var property cargador 
    const cadencia
    var property estado = disparar

    method precio()
    
    method quitarMunicion() {
        cargador -= 1
        if (cargador == 0) { 
        game.schedule(3000,{managerItems.siNoHayBalasSoltarle()})
        }
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
        estado = esperar
        game.schedule(cadencia, {estado = disparar})
    }

    method recargar(cant) {
        self.cargador((cargador + cant).min(self.municionMaxima()))
    }

    method hudMunicion()
    method sonidoRecarga()
    method municionMaxima()
}


object pistola inherits Arma(cadencia=500,cargador=12) {

    override method precio(){
        return 0
    }
    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new Bala(image="balaP-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
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

object doblePistola inherits Arma(cadencia=250,cargador=24) {

    override method precio(){
        return 80
    }
    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new Bala(image="balaP-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "balasDobles-"
    }

    override method sonidoRecarga() {
        game.sound("pistola-recarga.mp3").play() 
    }

    override method municionMaxima(){
        return 24
    }
}

object escopeta inherits Arma(cadencia=900,cargador=6) {

    override method precio(){
        return 80
    }

    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new BalaEscopeta(image="balaEscopeta-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "cartuchod-"
    }

    override method sonidoRecarga() {
        game.sound("pistola-recarga.mp3").play() 
    }

    override method municionMaxima(){
        return 6
    }
}

object escopetaPlateada inherits Arma(cadencia=450,cargador=12) {

    override method precio(){
        return 80
    }

    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new BalaEscopeta(image="balaEscopeta-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "cartuchodDoble-"
    }

    override method sonidoRecarga() {
        game.sound("pistola-recarga.mp3").play() 
    }

    override method municionMaxima(){
        return 12
    }
}

object dosManos inherits Arma(cadencia=800,cargador=12) {

    override method precio(){
        return 0
    }

    override method disparar(dir,pos) {
        super(dir,pos)
        self.hechizo(dir,pos)
    }

    method hechizo(dir,pos) {
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

object tresManos inherits Arma(cadencia=900,cargador=12) {

    override method precio(){
        return 80
    }

    override method disparar(dir,pos) {
        super(dir,pos)
        self.hechizo(dir,pos)
    }

    method hechizo(dir,pos) {
        const plasmaNuevo = new BolaPlasma(image="plasma-" + dir.toString() + ".png", position = dir.siguientePosicion(pos))
        game.addVisual(plasmaNuevo)
        plasmaNuevo.nuevoViaje(dir)
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

object cuatroManos inherits Arma(cadencia=700,cargador=12) {
    
    override method precio(){
        return 80
    }

    override method disparar(dir,pos) {
        super(dir,pos)
        self.hechizo(dir,pos)
    }

    method hechizo(dir,pos) {
        const calavera = new Calavera(image="calavera-" + dir.toString() + ".png", position = dir.siguientePosicion(pos))
        game.addVisual(calavera)
        calavera.nuevoViaje(dir)
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

object disparar {
    method gatillar(dir,pos,arma) {
        arma.disparar(dir,pos)
    }
}

object esperar {
    method gatillar(dir,pos,arma) {}
}