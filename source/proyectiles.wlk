import personajes.personaje.*
import wollok.game.*
import posiciones.*
import enemigos.*
import managers.*

class Proyectil {

    var property danio
    var property image
    var property position

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method disparoHacia(direccion)

    method sigueOHayZombie(direccion) {
        const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)}) // reotcasr
        return (not(zombiesHacia.isEmpty()))
    }

    method sigueOEsta(direccion, zombie) {
        return zombie.position() == direccion.siguientePosicion(position) or zombie.position() == position
    }

    method colisionPj() {} // por si las dudas -_-

    method impacto(dir) {
        game.removeTickEvent(self.nombreEvento())
        game.schedule(100,{game.removeVisual(self)})
    }

    method validarViajeProyectil(direccion) {
        if (self.sigueOHayZombie(direccion)) {
            const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)})
            zombiesHacia.forEach({zombie => zombie.herir(danio)})
            self.impacto(direccion)
        }
        else if (not(tablero.estaDentro(direccion.siguientePosicion(position)))) {
            self.impacto(direccion)
        }
    }

    method traspasable() {
        return true
    }
}

class Bala inherits Proyectil(danio = 20) {


    method nuevoViaje(dir) { 
        game.onTick(120, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    method imagenEnNumDir(num,direccion) {
       return "bala-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.animacionBala(direccion)
    }

    method animacionBala(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(20,{self.imagenEnNumDir(3, direccion)})
        game.schedule(40,{self.imagenEnNumDir(4, direccion)})
        game.schedule(60,{self.mover(direccion)})
        game.schedule(80,{self.imagenEnNumDir(1, direccion)})
    }

    override method impacto(dir) {
        self.image("bala-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}

class BolaDeFuego inherits Proyectil(danio = 30) {

    method nuevoViaje(dir) { 
        game.onTick(150, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    method imagenEnNumDir(num,direccion) {
        return "bola-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.animacionBola(direccion)
    }

    method animacionBola(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(20,{self.imagenEnNumDir(3, direccion)})
        game.schedule(50,{self.imagenEnNumDir(4, direccion)})
        game.schedule(80,{self.mover(direccion)})
        game.schedule(100,{self.imagenEnNumDir(1, direccion)})
    }

    override method impacto(dir) {
        self.image("bola-impacto-" + dir.toString() + ".png")
        super(dir)
    } 
}

class Crater {
    var property image = "tanqueimpacto.png"
    const property position

    method colisionPj() {}

    method daniar(dmg) {
        const colisiones = managerZombie.zombies().filter({z => z.position() == position})
        if (personaje.position() == position) {
            colisiones.add(personaje)
        }
        colisiones.forEach({c => c.herir(dmg)})
        game.schedule(2000,{game.removeVisual(self)})
    }

    method traspasable() {
        return true
    }
}

class Acido {
    var property image = "arbusto.png" // imagen -_-
    const property position
    
    method colisionPj() {}

    method daniar(dmg) {
        game.onTick(500, self.identidad(), {self.colisiones().forEach({c => c.herir(dmg)})})
        game.schedule(3550, {game.removeTickEvent(self.identidad())})
        game.schedule(4000,{game.removeVisual(self)})
    }

    method colisiones() {
        const colisiones = managerZombie.zombies().filter({z => z.position() == position})
        if (personaje.position() == position) {
            colisiones.add(personaje)
        }
        return colisiones
    }

    method identidad() {
        return self.identity().toString()
    }

    method traspasable() {
        return true
    }
}

class Especial inherits Proyectil(danio = 100) {

    method nuevoViaje(dir) { 
        game.onTick(150, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.avanzarEspecial(direccion)
    }

    method avanzarEspecial(direccion) {
        game.schedule(80,{self.mover(direccion)})
    }

    override method impacto(dir) {
        // cambiar por un impacto de rayo
        self.image("bola-impacto-" + dir.toString() + ".png")
        super(dir)
    } 
}