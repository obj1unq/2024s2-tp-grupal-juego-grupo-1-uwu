import personajes.personaje.*
import wollok.game.*
import juego.*
import posiciones.*
import enemigos.*

class Proyectil {

    var property danio
    var property image
    var property position
    const velocidadViaje

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.mover(direccion)
    }

    method sigueOHayZombie(direccion) {
        const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)}) // reotcasr
        return (not(zombiesHacia.isEmpty()))
    }

    method sigueOEsta(direccion, zombie) {
        return zombie.position() == direccion.siguientePosicion(position) or zombie.position() == position
    }

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

    method nuevoViaje(dir) { 
        game.onTick(velocidadViaje, self.nombreEvento() , {self.disparoHacia(dir)})
    }

}


class Bala inherits Proyectil(danio=25, velocidadViaje=120) {

    override method impacto(dir) {
        self.image("bala-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}


class BalaEscopeta inherits Proyectil(danio= 75,velocidadViaje=180) {

    override method impacto(dir) {
        self.image("balaEscopetaPrueba-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}


class BolaDeFuego inherits Proyectil(danio=40, velocidadViaje=220) {

    override method impacto(dir) {
        self.image("bola-impacto-" + dir.toString() + ".png")
        super(dir)
    } 
}


object managerCrater {

    method explosionEnCon(pos,dmg) {
        tablero.alrededoresDe(pos).forEach({pos => self.aparecerCraterEn(pos,dmg)})
    }

    method aparecerCraterEn(pos,dmg) {
        const craterNuevo = new Crater(position=pos)
        game.addVisual(craterNuevo)
        craterNuevo.daniar(dmg)
    }
}


class Crater {
    var property image = "tanqueimpacto.png"
    const property position

    method daniar(dmg) {
        const colisiones = managerZombie.zombies().filter({z => z.position() == position})
        if (juego.jugador().position() == position) {
            colisiones.add(juego.jugador())
        }
        colisiones.forEach({c => c.herir(dmg)})
        game.schedule(2000,{game.removeVisual(self)})
    }

}


object managerAcido {
    
    method acidoEnCon(pos, dmg) {
        const acidoNuevo = new Acido(position = pos)
        game.addVisual(acidoNuevo)
        acidoNuevo.daniar(dmg)
    }
}


class Acido {
    
    var property image = "arbusto.png"
    const property position

    method daniar(dmg) {
        game.onTick(500, self.identidad(), {self.colisiones().forEach({c => c.herir(dmg)})})
        game.schedule(3550, {game.removeTickEvent(self.identidad())})
        game.schedule(4000,{game.removeVisual(self)})
    }

    method colisiones() {
        const colisiones = managerZombie.zombies().filter({z => z.position() == position})
        if (juego.jugador().position() == position) {
            colisiones.add(juego.jugador())
        }
        return colisiones
    }

    method identidad() {
        return self.identity().toString()
    }

}


class BolaEnergia inherits Proyectil(danio = 100, image="rayoGrande.png",velocidadViaje=150) {

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


class Baston inherits Proyectil(danio = 100, image= "hacerla.png", velocidadViaje=170) {

}