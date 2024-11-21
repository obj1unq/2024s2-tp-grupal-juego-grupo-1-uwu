import extras.*
import wollok.game.*
import personajes.personaje.*
import juego.*

//---------------------------------Timer---------------------------------------


object timer {

    var segundos = 0
    var minutos  = 0

    method position() {
        return game.at(11, game.height() - 1 )
    }

    method text() {
        return minutos.toString() +":"+ segundos.toString()
    }

    method textColor() {
        return "FFFFFF"
    }

    method tick() {
        if(segundos < 60){
            segundos += 1
        }else{
            minutos += 1
            segundos = 0
            segundos += 1
        }
    }

}
//----------------------------------------------HUD-----------------------------
object barra{
    var property image =  "blacklong.png"
    var property position = game.at(0, 14)

}
//----------------------------------BARRA DE VIDA-----------------------------

object puntosDeVida {
    var vida = 100
    var property image =  "barravida-100.png"
    var property position = game.at(0, 14)

    method curarse(cura){
        game.sound("cura-sonido.mp3").play()
        vida = 100.min(vida + cura) 
        self.actualizar()
    }

    method herir(cant) {
        vida = 0.max(vida - cant)
        self.actualizar()
        self.revisarMorir()
    }

    method revisarMorir() {
        if (vida == 0) {
            self.muerte()
        }
    }

    method muerte() {
        juego.jugador().sonidoMuerte()
        game.clear()
        // pantalla muerte
        game.schedule(1000, {game.stop()})
    }

    method actualizar(){
        self.image("barravida-" + vida.toString() + ".png")
    }
}

//----------------------------------------------MUNICION-----------------------------

object hudBalas {
    var property position = game.at(4, 14)

    method balas() {
        return juego.jugador().arma().municion()
    }

    method image(){
        return juego.jugador().arma().hudMunicion() + juego.jugador().arma().cargador() + ".png"
    }
    
    
}


//----------------------------------------------ORO-----------------------------
object oroObtenido {

    method position() {
        return game.at(10, game.height() - 1 )
    }

    method text() {
        return juego.jugador().oro().toString()
    }

    method textColor() {
        return "ffff00"
    }

    method impactoProyectil(danio) {}

}


//----------------------------------------------energia-----------------------------


object barraDeEnergia {

    var property image =  "energia-"+ energia.toString() + ".png"
    var property energia = 10

    method position() {
            return game.at(12, 14)
    }
    
    method validarEnergia(){
        if (energia > 0){
            self.quitarEnergia(1)
        }
        else {self.error("")}
    }

    method quitarEnergia(cantidad) {
        energia -= cantidad
        self.image("energia-"+ energia.toString() + ".png") 
    }

    method recargarEnergia(){
        energia = (energia + 1).min(10)
        self.image("energia-"+ energia.toString() + ".png") 
    }

}

object especial {

    var property zombiesAsesinados = 0 

    method tirarEspecial() {
        self.validarEspecial()
        self.zombiesAsesinados(0)
        juego.jugador().lanzarEspecial()
    }

    method murioZombie() {
        zombiesAsesinados += 1
    }

    method validarEspecial() {
        if (zombiesAsesinados < 6) self.error("")
    } 

  
}