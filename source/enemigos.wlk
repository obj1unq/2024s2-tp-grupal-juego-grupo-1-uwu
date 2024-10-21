import extras.*
import wollok.game.*
import posiciones.*
import personajes.personaje.*
import sonidos.*

object managerZombie {
    const property zombies = #{}

    method spawnearZombieComun() {
        const zombieSpawneado = new Perro(position = game.at(game.width() -2, game.height() -2))
        zombies.add(zombieSpawneado)
        game.addVisual(zombieSpawneado)
        zombieSpawneado.persecucion()
    }
}

class Zombie {

    var property image
    var property position
    var property vida
    var property dmg
    var property velocidad

    method colisionPj() {}

    method agro() {
        return personaje
    }

    method impactoProyectil(danio) {
        vida = 0.max(vida - danio)
        self.fijarseMuerte()
        self.sonidoHerida()
    }

// Persecucion -------------------------------------

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method persecucion() {
        game.onTick(velocidad, self.nombreEvento(), {self.perseguirAPersonaje()})
    }

    method perseguirAPersonaje() {
        self.moverseHaciaAgro()
        self.atacarSiPuede() 
    }

    method atacarSiPuede() {
        if (self.estaSobreAgro()) {
            self.herirAgro()
        }
    }

    method estaSobreAgro() {
        return game.onSameCell(position, self.agro().position())
    }

    method moverseHaciaAgro() {
        self.moverseHaciaAgroEjeX()
        game.schedule(500, {self.moverseHaciaAgroEjeY()})
    }

// Movimiento -------------------------------------

    method moverseHaciaAgroEjeY() {
        if (self.agro().position().y() > position.y()) {
            self.mover(arriba)
            self.image(self.imagenHacia(arriba))
        }
        else if (self.agro().position().y() < position.y()) {
            self.mover(abajo)
            self.image(self.imagenHacia(abajo))
        }
    }

    method moverseHaciaAgroEjeX() {
        if (self.agro().position().x() > position.x()) {
            self.mover(derecha)
            self.image(self.imagenHacia(derecha))
        }
        else if (self.agro().position().x() < position.x()) {
            self.mover(izquierda)
            self.image(self.imagenHacia(izquierda))
        }
    }

    method imagenHacia(dir) {
        return self.imagenMovimiento() + dir.toString() + ".png"
    }

    method imagenMovimiento()

    method mover(direccion) {
	    position = direccion.siguientePosicion(self.position()) 
	}

// Ataque -----------------------------------------

    method herirAgro() {
        self.agro().herir(dmg)
    }

// Vida -------------------------------------------

    method fijarseMuerte() {
        if (vida == 0) {
            self.sonidoMuerte()
            game.removeVisual(self)
            game.removeTickEvent(self.nombreEvento())
            managerZombie.zombies().remove(self)
            managerItems.spawnearMunicionEn(self.position())
        }
    }

// Sonido -------------------------------------------

    method sonidoHerida()

    method sonidoMuerte()

}

class ZombieComun inherits Zombie(vida = 100, dmg = 10, velocidad = 1000, image = "zombie-comun-abajo.png"){

    override method imagenMovimiento() {
        return "zombie-comun-"
    }

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }
}

class Perro inherits Zombie(vida = 50, dmg = 20,  velocidad = 500, image = "perronio-abajo.png"){

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