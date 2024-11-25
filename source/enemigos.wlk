import wollok.game.*
import juego.*
import posiciones.*
import sonidos.*
import nivelManager.*
import managers.*


class Zombie {
    var property image
    var property position
    var property vida
    const property dmg
    var contadorMovimiento = 1
    const velocidad

    method agro() {
        return juego.jugador()
    }

    method herir(danio) {
        vida = 0.max(vida - danio)
        self.sonidoHerida()
        self.fijarseMuerte()
    }
    
    method fijarseMuerte() {
        if (vida == 0) {
           self.morir() 
        }
    }

    method atacarAgro() {
        self.imagenHacia(self.dirAgroPegado())
        self.agro().herir(dmg)
    }

    method sonidoHerida()
    method sonidoMuerte()

    // Persecucion -------------------------------------

    method perseguirAJugador() {
        if (self.agroEstaPegado()) {
            self.atacarAgro()
        }
        else if (contadorMovimiento == velocidad) {
            self.imagenHacia(self.dirDeTransicionA(self.sigPosFavorable()))
            position = self.sigPosFavorable()
            contadorMovimiento = 1
        }
        else {contadorMovimiento += 1}
    }

    method agroEstaPegado() {
        return self.position().distance(self.agro().position()) == 1
    }

    method dirDeTransicionA(pos) {
        if (pos.x() > position.x()) {
            return derecha
        }
        else if (pos.x() < position.x()) {
            return izquierda
        }
        else if (pos.y() > position.y()) {
            return arriba
        }
        else {
            return abajo
        }
    }

    method sigPosFavorable() {
        const disponibles = tablero.verticalesDe(position).filter({pos => not(managerZombie.posTieneZombie(pos))})
        const dispYSinCajas = disponibles.filter({pos => not(nivelManager.hayCajaEn(pos))})
        return dispYSinCajas.min({pos => pos.distance(self.agro().position())})
    }

    method dirAgroPegado() {
        if (self.distanciaY() == 0 and self.distanciaX() < 0) {
            return izquierda
        }
        else if (self.distanciaY() == 0 and self.distanciaX() > 0) {
            return derecha
        }
        else if (self.distanciaX() == 0 and self.distanciaY() < 0) {
            return abajo
        }
        else {
            return arriba
        }
    }

    method distanciaX() {
        return (self.agro().position().x() - position.x())
    }

    method distanciaY() {
        return (self.agro().position().y() - position.y())
    }

    // Movimiento -------------------------------------

    method imagenHacia(dir) {
        image = self.imagenMovimiento() + dir.toString() + ".png"
    }

    method imagenMovimiento()

    method morir() {
        self.sonidoMuerte()
        game.removeVisual(self)
        managerZombie.quitarZ(self)
        //nivelManager.incrementarEnemigos() //-- niveles
        managerItems.generarDrop(position)
        //managerItems.spawnearMunicionEn(self.position())
    }
}

class ZombieComun inherits Zombie(vida = 100, dmg = 10, image = "zombieComun-abajo.png", velocidad=2){ 

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    override method imagenMovimiento() {
        return "zombieComun-"
    }
}

class ZombiePerro inherits Zombie(vida = 75, dmg = 20, image = "perronio-abajo.png",velocidad=1){

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    override method imagenMovimiento() {
        return "perronio-"
    }
}

class ZombieTanque inherits Zombie(vida = 150, dmg = 50, image = "tanque-1-abajo.png", velocidad=3) {
    
    var estado = 1
    var ultimaDir = abajo

    override method herir(danio) {
        super(danio * 0.75)             // recibe un 25% menos de daño (Por tener "armadura")
    }

    override method atacarAgro() {
        ultimaDir = self.dirAgroPegado()
        managerZombie.quitarZ(self)
        self.animacionAtaque() 
        game.schedule(1250,{managerCrater.explosionEnCon(position,dmg)}) 
        game.schedule(1500,{managerZombie.agregarZ(self)})
    }

    method animacionAtaque() {
        estado = 2
        self.imagenHacia(ultimaDir)
        game.schedule(600,{estado += 1})
        game.schedule(650,{self.imagenHacia(ultimaDir)})
        game.schedule(1200,{estado += 1})
        game.schedule(1200,{self.imagenHacia(ultimaDir)})
        game.schedule(1250,{estado = 1})
        game.schedule(1450,{self.imagenHacia(ultimaDir)})
    }

    override method morir() {
        self.explotar()
        super()
    }

    method explotar() {
        managerCrater.explosionEnCon(position, dmg)
    }

    // sonido -----------------------------------------
    
    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play() // hay q ponerle otros sonidos
    }

    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "tanque-" + estado.toString() + "-"
    }
}

class ZombieThrower inherits Zombie(vida = 20, dmg = 10, image = "expectorador-1-abajo.png",velocidad=2){  
    var contador = 0
    var estado = 1
    var positionAtaque = game.at(0, 0)

    override method perseguirAJugador() {
        if(!self.agroEstaAbajo() and !self.estaAlFinalIzquierdo() and contador.even()) {
            self.moverse(izquierda)
        } else if(!self.agroEstaAbajo() and !self.estaAlFinalDerecho() and !contador.even()) {
            self.moverse(derecha)
        } else if (!self.agroEstaAbajo() and self.estaAlFinalDerecho()){
            contador += 1
            self.moverse(izquierda)
        } else if (!self.agroEstaAbajo() and self.estaAlFinalIzquierdo()){
            contador += 1
            self.moverse(derecha)
        } else {
            self.atacarAPersonaje() 
        }
    }

    method atacarAPersonaje() {
        positionAtaque = self.agro().position()
        self.atacarAgro()
    }

    method moverse(dir) {
        position = dir.siguientePosicion(position)
        self.imagenHacia(dir)
    }

    // movimiento ------------------------------------

    method estaAlFinal() {
        return  self.estaAlFinalIzquierdo() or self.estaAlFinalDerecho()
    }

    method estaAlFinalDerecho() {
        return position.x() == game.width() - 1
    }

    method estaAlFinalIzquierdo() {
        return position.x() == 0
    }

    method agroEstaAbajo() {
        return self.agro().position().x() == self.position().x()
    }

    // ataque ------------------------------
    override method atacarAgro() {
        managerZombie.quitarZ(self)
        self.animacionAtaque()
        game.schedule(1250,{managerAcido.acidoEnCon(positionAtaque, dmg)})
        game.schedule(1500,{managerZombie.agregarZ(self)})    
    }

    method animacionAtaque() {
        estado = 2
        self.imagenHacia(self.direccionAtaque())
        game.schedule(600,{estado += 1})
        game.schedule(650,{self.imagenHacia(self.direccionAtaque())})
        game.schedule(1200,{estado += 1})
        game.schedule(1200,{self.imagenHacia(self.direccionAtaque())})
        game.schedule(1250,{estado = 1})
        game.schedule(1450,{self.imagenHacia(self.direccionAtaque())})
    }

    method direccionAtaque() {
        return if(position.x() == 0) arriba else abajo
    }

    // sonido -----------------------------------------

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "expectorador-" + estado.toString() + "-"
    }
}
