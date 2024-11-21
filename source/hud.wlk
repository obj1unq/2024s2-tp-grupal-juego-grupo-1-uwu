import wollok.game.*
import personajes.personaje.*

//---------------------------------Timer---------------------------------------

object timer {

    var segundos = 0
    var minutos  = 0

    method position() {
        return game.at(8, game.height() - 1 )
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

    method colisionPj() {}

    method impactoProyectil(danio) {}

    method traspasable() {
        return true
    }

}
//----------------------------------------------HUD-----------------------------
object barra{
    var property image =  "blacklong.png"
    var property position = game.at(0, 16)

    method impactoProyectil(danio) {}
    method colisionPj() {}
    //game.addVisual("black.png")

    method traspasable() {
        return false
    }
}
//----------------------------------BARRA DE VIDA-----------------------------

object puntosDeVida {

    var property image =  "barravida-100.png"
    var property position = game.at(0, 16)

    method actualizar(){
        self.image("barravida-" + personaje.vida() + ".png")
    }

    method colisionPj() {}

    method impactoProyectil(danio) {}

    method traspasable() {
        return false
    }
}

//----------------------------------------------MUNICION-----------------------------

object cargador {
    var property  municion = 12 
    const property duenio = personaje.pj()
    var property position = game.at(4, 16)

    method image(){
        return duenio.hudMunicion() + municion.toString() + ".png"
    }
    
    method recargar(balas){
        duenio.sonidoRecarga()
        municion += balas
        municion = municion.min(12) 
    }

    method validarAtaque(dir){
        if (municion == 0){
            duenio.sinMunicion(dir)
            self.error("")
        }
        else {self.quitarMunicion(1)}
    }

    method quitarMunicion(cantidad) {
        municion -= cantidad
    }
    
    method colisionPj() {}

    method impactoProyectil(danio) {}

    method traspasable() {
        return false
    }


}


//----------------------------------------------ORO-----------------------------
object oroObtenido {

    method position() {
        return game.at(10, game.height() - 1 )
    }

    method text() {
        return personaje.oro().toString()
    }

    method colisionPj() {}

    method textColor() {
        return "ffff00"
    }

    method impactoProyectil(danio) {}

    method traspasable() {
        return false
    }
}


//----------------------------------------------energia-----------------------------


object barraDeEnergia {

    var property image =  "energia-"+ energia.toString() + ".png"
    var property energia = 10
    const property duenio = personaje

    method position() {
            return game.at(12, 16)
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
        energia = 10.min(energia + 1)
        self.image("energia-"+ energia.toString() + ".png") 
    }
    
    method colisionPj() {}

}

//----------------------------------------------energia-----------------------------
object especial {
  const duenio = personaje

  method validarEspecial(direccion) = if (not self.especialListo(direccion)) self.error("")

  method especialListo(direccion) {
      return 0 == duenio.necesariosParaEspecial() % duenio.derrotados()
    }
}