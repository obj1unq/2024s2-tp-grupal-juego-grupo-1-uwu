import extras.*
import wollok.game.*
import posiciones.*
import personajes.personaje.*
import sonidos.*
import proyectiles.*
import managers.*

object generadorZombie {

    method zombieComun(posicion) {
        return new ZombieComun(position = posicion)
    }

    method zombiePerro(posicion) {
        return new ZombiePerro(position = posicion)
    }
    
    method zombieThrower(posicion) {
        return new ZombieThrower(position = posicion)
    }
        
    method zombieTanque(posicion) {
        return new ZombieTanque(position = posicion)
    }

    method posicionInicial() {
        return game.at(game.width() -3, game.height() -3)
    }
}

// testear probabilidad zombies(funciona, pero laguea una banda LPM jsjs)

object randomizadorZombies {
    var property posicionSpawn = game.at(0, 0)

    method posicionAleatoria() {
        const posicion = 1.randomUpTo(4)
        return self.elegirPosicion(posicion)
    }

    method posicionesSpawneo() {
        return [game.at(0, 0), game.at(game.width() - 1, 0),
            game.at(game.width() - 1, game.height() - 2), game.at(0, game.height() - 2)]
    }

    // arreglar pq el expectorador mira hacia abajo al disparar en position.x() = 0

    method zombiesAGenerar(posicion) {
        return [generadorZombie.zombieComun(posicion), generadorZombie.zombiePerro(posicion),
                generadorZombie.zombieTanque(posicion), generadorZombie.zombieThrower(posicion)]
    }

    method elegirZombie(numero, posicion) {
        return self.zombiesAGenerar(posicion).get(numero - 1)
    }

    method elegirPosicion(numero) {
        return self.posicionesSpawneo().get(numero - 1)
    }

    method randomizarZombie(posicion) {
        const probabilidad = 0.randomUpTo(100)
        return self.probabilidadZombies(probabilidad, posicion)
    }

    method probabilidadZombies(numero, posicion) {
        return 
            if(numero < 50) self.elegirZombie(1, posicion)
            else if(numero >= 50 and numero < 75) self.elegirZombie(2, posicion)
            else if(numero >= 75 and numero < 87.5) self.elegirZombie(3, posicion)
            else self.elegirZombie(4, posicion)
    }
}

class Zombie {
    var property image
    var property position
    var property vida
    const property dmg
    const property velocidad

    method agro() {
        return personaje
    }

    method colisionPj() {}

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method traspasable() {
        return false
    }

    method persecucion() {
        game.onTick(velocidad, self.nombreEvento(), {self.perseguirAPersonaje()})
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

    method perseguirAPersonaje() {
        if (self.agroEstaPegado()) {
            self.atacarAgro()
        }
        else {
            self.imagenHacia(self.dirDeTransicionA(self.sigPosFavorable()))
            position = self.sigPosFavorable()
        }
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
        const disponibles = tablero.alrededoresDe(position).filter({pos => not(managerZombie.posTieneZombie(pos))})
        return disponibles.min({pos => pos.distance(self.agro().position())})
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
        game.removeTickEvent(self.nombreEvento())
        managerZombie.quitarZ(self)
        personaje.zombieDerrotado()
        managerItems.spawnearMunicionEn(self.position())
    }

    method resetearVisual() {
        game.removeTickEvent(self.nombreEvento())
        game.removeVisual(self)
        game.addVisual(self)
        self.persecucion()
    }
}

class ZombieComun inherits Zombie(vida = 100, dmg = 10, velocidad = 1000, image = "zombie-comun-abajo.png"){ 

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    override method imagenMovimiento() {
        return "zombie-comun-"
    }
}

class ZombiePerro inherits Zombie(vida = 50, dmg = 20,  velocidad = 700, image = "perronio-abajo.png"){

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

class ZombieTanque inherits Zombie(vida = 300, dmg = 50, velocidad = 1500, image = "tanque-1-abajo.png") {
    
    var estado = 1
    var ultimaDir = abajo

    override method herir(danio) {
        super(danio * 0.75)             // recibe un 25% menos de daño (Por tener "armadura")
    }

    override method atacarAgro() {
        ultimaDir = self.dirAgroPegado()
        game.removeTickEvent(self.nombreEvento())
        self.animacionAtaque() 
        game.schedule(1250,{managerCrater.explosionEnCon(position,dmg)}) 
        game.schedule(1500,{self.persecucion()})
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

class ZombieThrower inherits Zombie(vida = 20, dmg = 10, velocidad = 250, image = "expectorador-1-abajo.png"){  
    var contador = 0
    var estado = 1
    var positionAtaque = game.at(0, 0)

    override method perseguirAPersonaje() {
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
        game.removeTickEvent(self.nombreEvento())
        self.animacionAtaque()
        game.schedule(1250,{managerAcido.acidoEnCon(positionAtaque, dmg)})
        game.schedule(1500,{self.persecucion()})    
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