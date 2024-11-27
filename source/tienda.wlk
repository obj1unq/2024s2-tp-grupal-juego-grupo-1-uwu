import wollok.game.*
import juego.*
import stats.*

object tienda{
    
    var property oro = 0 //Delegar oro a hud
    
    var property image = "Tienda.png" 
    var property position = game.at(0,0)

    method oroActual() {
        return oro.min(999)
    }

    method obtenerOro(valor) {
        game.sound("agarrar-oro.mp3").play()
        oro += valor
    }

    method restarOro(valor) {
        oro -= valor
    }

    method position() {
            return game.at(0,0)
    }

    method inicializar() {
        
    }

    //Letra J
    method mejorarVida() { //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiAlcanzaOro(puntosDeVida.precio())
        self.validarSiVidaEstaAlMax()
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        puntosDeVida.subirMaximo()
        mejoraDeVida.animacionCompra()
        mejoraDeVida.actualizarSiLlegaAlMax()
        self.restarOro(puntosDeVida.precio())  
    }
    //Letra L
    method mejorarEnergia() { //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiAlcanzaOro(barraDeEnergia.precio())
        self.validarSiEnergiaEstaAlMax()
        barraDeEnergia.subirMaximo(3)
        mejoraDeEnergia.animacionCompra()
        mejoraDeEnergia.actualizarSiLlegaAlMax()
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        self.restarOro(barraDeEnergia.precio())   
    }

    //letra K
    method mejorarArma() { //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiArmaEstaAlMax()
        self.validarSiAlcanzaOro(juego.jugador().precioSiguienteArma())
        juego.jugador().mejorarArma()
        game.sound("mejora.mp3").play()
        game.sound("good-choice.mp3").play()
        self.restarOro(barraDeEnergia.precio())   
    }

    //Validaciones
    method validarSiAlcanzaOro(precio) {
        if(oro < precio){
            game.sound("not-enough-cash.mp3").play()
            self.error("")} //No alcanza el oro
    }

    method validarSiVidaEstaAlMax() {
        if(puntosDeVida.vidaMax() == 100){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //La vida esta al maximo
    }

    method validarSiEnergiaEstaAlMax() {
        if(barraDeEnergia.energiaMaxima() == 20){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //La energia esta al maximo
    }

    method validarSiArmaEstaAlMax() {
        if(not juego.jugador().quedanArmasPorMejorar()){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //No quedan armas por mejorar
    }
}

class MejoraDeStat {
    var property image
    var property position = game.at(0,0)

    method actualizarSiLlegaAlMax()
    method animacionCompra()
}
object mejoraDeVida inherits MejoraDeStat(image = "VidaUp.png") {

    override method actualizarSiLlegaAlMax(){
        if(puntosDeVida.vidaMax()== 100){
            game.schedule(1001,{image = "VidaUp-agotado.png"}) 
        }
    }

    override method animacionCompra(){
        image = "VidaUp-compra.png"
        game.schedule(1000,{image = "VidaUp.png" }) 
    }
}

object mejoraDeEnergia inherits MejoraDeStat(image = "EnergiaUp.png") {

    override method actualizarSiLlegaAlMax(){
        if(barraDeEnergia.energiaMaxima() == 20){
            game.schedule(1001,{image = "EnergiaUp-agotado.png"}) 
        }
    }

    override method animacionCompra(){
        image = "EnergiaUp-compra.png"
        game.schedule(1000,{image = "EnergiaUp.png" }) 
    }
}

object mejoraDeArma {

    
    var property position = game.at(0,0)

    method image() {
        if(juego.jugador().armas().isEmpty()){
            return juego.jugador().arma() + "-agotado.png"
        }else {
            return juego.jugador().armas().first().toString() +".png"
        }
    }
}

class Numero {
    method valor()
    var property position = game.at(0,0)

    method agregarAlJuego() {
        game.addVisual(new Unidad(num=self))
        game.addVisual(new Decena(num=self))
        game.addVisual(new Centena(num=self))
    } 
}

class Digito {
    var property num 
    method position() {return num.position()}
    method image() 
    method digito() {return self.extraer(num.valor().toString())}
    method extraer(string) 
}

class Unidad inherits Digito() {
    override method image() {}
}   

class Decena inherits Digito() {
    override method image() {}
}

class Centena inherits Digito() { 
    override method image() {}
}