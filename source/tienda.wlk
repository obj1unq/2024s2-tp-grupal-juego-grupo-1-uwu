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
    method mejorarVida(){ //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiVidaEstaAlMax()
        self.validarSiAlcanzaOro(puntosDeVida.precio())
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        puntosDeVida.subirMaximo()
        mejoraDeVida.actualizarSiLlegaAlMax()
        self.restarOro(puntosDeVida.precio())  
    }
    //Letra L
    method mejorarEnergia(){ //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiEnergiaEstaAlMax()
        self.validarSiAlcanzaOro(barraDeEnergia.precio())
        barraDeEnergia.subirMaximo(3)
        mejoraDeEnergia.actualizarSiLlegaAlMax()
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        self.restarOro(barraDeEnergia.precio())   
    }

    //letra K
    method mejorarArma(){ //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiArmaEstaAlMax()
        self.validarSiAlcanzaOro(juego.jugador().precioSiguienteArma())
        juego.jugador().mejorarArma()
        //Cambiar imgen si llego al maximo
        game.sound("mejora.mp3").play()
        game.sound("good-choice.mp3").play()
        self.restarOro(barraDeEnergia.precio())   
    }

    //Validaciones
    method validarSiAlcanzaOro(precio){
        if(oro < precio){
            game.sound("not-enough-cash.mp3").play()
            self.error("")} //No alcanza el oro
    }

    method validarSiVidaEstaAlMax(){
        if(puntosDeVida.vidaMax() == 100){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //La vida esta al maximo
    }

    method validarSiEnergiaEstaAlMax(){
        if(barraDeEnergia.energiaMaxima() == 20){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //La energia esta al maximo
    }

    method validarSiArmaEstaAlMax(){
        if(juego.jugador().armas().isEmpty()){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //No quedan armas por mejorar
    }
}

object mejoraDeVida {

    var property image = "VidaUp.png" 
    var property position = game.at(0,0)

    method actualizarSiLlegaAlMax(){
        if(puntosDeVida.vidaMax()== 100){
            image = "VidaUp-agotado.png"
        }
    }
}

object mejoraDeEnergia {

    var property image = "EnergiaUp.png" 
    var property position = game.at(0,0)

    method actualizarSiLlegaAlMax(){
        if(barraDeEnergia.energiaMaxima() == 20){
            image = "EnergiaUp-agotado.png"
        }
    }
}

object mejoraDeArma {

    
    var property position = game.at(0,0)

    method image(){
        if(juego.jugador().armas().isEmpty()){
            return juego.jugador().arma() + "-agotado.png"
        }else {
            return juego.jugador().armas().first().toString() +".png"
        }
    }
}
