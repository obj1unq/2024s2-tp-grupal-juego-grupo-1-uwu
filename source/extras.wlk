import hud.*
import wollok.game.*
import personajes.personaje.*
import juego.*
import posiciones.*

object managerItems {
    
    const property drops = #{}  
    var balasEnTablero = 0

    method restarBalasDeTablero() {
        balasEnTablero -= 1
    }

    // Oro = 25% / Municion = 40% / Vida = 20% / Nada = 15% 
    method generarDrop(posicion) {
        const numero = 0.randomUpTo(100).round()

        self.validarDropsEnPantalla()
        if (numero <= 25) { 
            self.spawnearOro(0.randomUpTo(3).round().max(1), posicion)
        } else if (numero > 25 and numero <= 65) {
            self.spawnearMunicion(posicion)
        } else if (numero > 65 and numero <= 85) {
            self.spawnearCura(0.randomUpTo(3).round().max(1) , posicion)
        } 
    }

    method validarDropsEnPantalla(){
        if (drops.size() > 2){self.error("")}
    }

    method generarDropRandom(){
        self.generarDrop(tablero.posicionRandom())
    }

    method quitarItem(item) {
        drops.remove(item)
    }

    method revisarPorItems(pos) {
        const itemAhi = drops.filter({d => d.position() == pos})
        itemAhi.forEach({d => d.colisionPj()})
    }

    method spawnearCura(numero, posicion) {
        const nuevaCura = managerCuras.cura(numero, posicion)
        game.addVisual(nuevaCura)
        drops.add(nuevaCura)
    }

    method spawnearOro(numero, posicion) {
        const oroNuevo = managerMonedas.monedas(numero, posicion)
        game.addVisual(oroNuevo)
        drops.add(oroNuevo)
    }

    method spawnearMunicionRandom() {
        const nuevaMunicion = new Balas(position = tablero.posicionRandom())
        game.addVisual(nuevaMunicion)
        drops.add(nuevaMunicion)
    }

    method spawnearMunicion(posicion) {
        balasEnTablero += 1
        const nuevaMunicion = new Balas(position = posicion)
        game.addVisual(nuevaMunicion)
        drops.add(nuevaMunicion)
    }

    method posiblesBalas(municion) {
        if(municion==0) {
            game.schedule(6000,{self.siNoHayBalasSoltarle()})
        }
    }

    method siNoHayBalasSoltarle() {
        if (balasEnTablero == 0) {
            self.spawnearMunicionRandom()
        }
    }
}

//---------------------------------Drops---------------------------------------

class Drop {
    var property position
    var property image
}

object managerCuras {
    const vida = [20, 40, 80]

    method cura(numero, position) {
        return new Cura(image = juego.jugador().visualHealth(numero)
                , vidaDada = self.vida(numero), position = position)
    }

    method vida(numero) {
        return vida.get(numero - 1)
    }
}

object managerMonedas {
    const oro = [10, 30, 50]
    
    method monedas(numero, position) {
        return new Oro(image = "oro" + numero + ".png",
                valor = self.oro(numero), position = position)
    }

    method oro(numero) {
        return oro.get(numero - 1)
    }
}

//---------------------------------Curas---------------------------------------
class Cura inherits Drop {
    const vidaDada

    method colisionPj() {
        puntosDeVida.curarse(vidaDada)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Monedas---------------------------------------

class Oro inherits Drop()  {
    const valor

    method colisionPj() {
        juego.jugador().obtenerOro(valor)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Municion---------------------------------------

class Balas inherits Drop(image = juego.jugador().visualAmmo()){

    method colisionPj() {
        juego.jugador().arma().recargar(6)
        game.removeVisual(self)
        managerItems.quitarItem(self)
        managerItems.restarBalasDeTablero()
    }
}


//---------------------------------Colisiones---------------------------------------

object muro  {

    var property position = game.at(8,8)
    var property image = "madera.png"
}

object municionActual {

    method position() {return game.at(6, game.height() - 1 )}

    method text() {return juego.jugador().arma().cargador().toString()}

    method colisionPj() {}

    method textColor() {return "FFFFFF"}

}

