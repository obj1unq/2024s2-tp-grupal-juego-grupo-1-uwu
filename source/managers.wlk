// acá es para poner todos los managers y que no estén sueltos por ahí
import proyectiles.*
import posiciones.*
import juego.*
import extras.*
import personajes.personaje.*
import enemigos.*

object managerAcido {
    method acidoEnCon(pos, dmg) {
        const acidoNuevo = new Acido(position = pos)
        game.addVisual(acidoNuevo)
        managerVisual.resetearVisuales()
        acidoNuevo.daniar(dmg)
    }
}

object managerCrater {

    method explosionEnCon(pos,dmg) {
        tablero.alrededoresDe(pos).forEach({pos => self.aparecerCraterEn(pos,dmg)})
        managerVisual.resetearVisuales()
    }

    method aparecerCraterEn(pos,dmg) {
        const craterNuevo = new Crater(position=pos)
        game.addVisual(craterNuevo)
        craterNuevo.daniar(dmg)
    }
}

object managerVisual {
    const visuales = #{}

    method agregarVisual(visual) { 
        game.addVisual(visual)
        visuales.add(visual)
    }

    method removerVisual(visual) {
        game.removeVisual(visual)
        visuales.remove(visual)
    }

    method resetearVisuales() {
        visuales.forEach({v => v.resetearVisual()})
    }
}

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

object managerCuras {
    const vida = [20, 40, 80]

    method cura(numero, position) {
        return new Cura(image = personaje.visualHealth(numero)
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

object managerZombie {
    const property zombies = #{}

    method agregarZ(zombie) {
        zombies.add(zombie)
    }

    method quitarZ(zombie) {
        zombies.remove(zombie)
        especial.murioZombie()
    }

    method spawnearZ(zombie) {
        zombies.add(zombie)
        game.addVisual(zombie)
    }

    method generarZombieAleatorio(posicion) {
        const zombieNuevo = randomizadorZombies.randomizarZombie(posicion)
        zombies.add(zombieNuevo)
        game.addVisual(zombieNuevo)
        zombieNuevo.persecucion()
    }

    method posTieneZombie(pos) {
        return (zombies.any({zom => zom.position() == pos}))
    }
}

    method activarODesactivarGeneracionAleatoria() {
        if(contador.even()) {
            contador += 1
            game.onTick(3000, "generarZombiesRandom", {self.generarZombieAleatorio(randomizadorZombies.posicionAleatoria())})
        } else {
            contador += 1
            game.removeTickEvent("generarZombiesRandom")
        }
    }
}
