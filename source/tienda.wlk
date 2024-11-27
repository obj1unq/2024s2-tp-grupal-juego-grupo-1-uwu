import wollok.game.*
import juego.*
import stats.*
import pantallas.*
import estadosJuego.*

object tienda{
    
    var property oro = 999 //Delegar oro a hud
    const property ost = game.sound("sonido-tienda.mp3")
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
        ost.play()
        mercadoVisible.dibujar()
        juego.estado(enTienda)
    }

    //Letra J
    method mejorarVida() { //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiAlcanzaOro(50)
        self.validarSiVidaEstaAlMax()
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        puntosDeVida.subirMaximo()
        mejoraDeVida.animacionCompra()
        mejoraDeVida.actualizarSiLlegaAlMax()
        self.restarOro(50)  
    }
    //Letra L
    method mejorarEnergia() { //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiAlcanzaOro(50)
        self.validarSiEnergiaEstaAlMax()
        barraDeEnergia.subirMaximo(3)
        barraDeEnergia.recargarMax()
        mejoraDeEnergia.animacionCompra()
        mejoraDeEnergia.actualizarSiLlegaAlMax()
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        self.restarOro(50)   
    }

    //letra K
    method mejorarArma() { //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiArmaEstaAlMax()
        self.validarSiAlcanzaOro(80)
        juego.jugador().mejorarArma()
        game.sound("mejora.mp3").play()
        game.sound("good-choice.mp3").play()
        self.restarOro(80)
        mejoraDeArma.animacionCompra()   
    }

    //Validaciones
    method validarSiAlcanzaOro(precio) {
        if(oro < precio){
            game.sound("not-enough-cash.mp3").play()
            console.println("no te alcanza el oro")
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
            console.println("ya alcanzo el max")
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
            game.schedule(500,{image = "VidaUp-agotado.png"}) 
        }
    }

    override method animacionCompra(){
        image = "VidaUp-compra.png"
        game.schedule(500,{image = "VidaUp.png" }) 
    }
}

object mejoraDeEnergia inherits MejoraDeStat(image = "EnergiaUp.png") {

    override method actualizarSiLlegaAlMax(){
        if(barraDeEnergia.energiaMaxima() == 20){
            game.schedule(500,{image = "EnergiaUp-agotado.png"}) 
        }
    }

    override method animacionCompra(){
        image = "EnergiaUp-compra.png"
        game.schedule(500,{image = "EnergiaUp.png" }) 
    }
}

object mejoraDeArma {
    var property image = ""
    var property position = game.at(0,0)

    method animacionCompra() {
        if (!juego.jugador().quedanArmasPorMejorar()) {
            image = juego.jugador().arma().toString() + "-compra.png"
            game.schedule(500,{image = juego.jugador().arma().toString() + "-agotado.png"})
        }
        else {
            image = juego.jugador().arma().toString() + "-compra.png"
            game.schedule(500,{image = juego.jugador().sigArma().toString() + ".png"})
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