import pantallas.*
import wollok.game.*
import estadosJuego.*
import enemigos.*
import juego.*
import managers.*
import etapas.etapa1.*
import etapas.etapa2.*
import etapas.etapa3.*
import etapas.etapa4.*

import personajes.personaje.*

object nivelManager {
    const property niveles = [niv6,niv2,niv3,niv4,niv5,
                              niv6,niv7,niv8]

    var property obstaculos = #{}

    var property enemigosTotales = 0
    var property enemigosAsesinados = 0

    method posicionesTapadas() {
        return obstaculos.map({o => o.position()})
    }

    method hayCajaEn(pos) {
        return self.posicionesTapadas().any({p => p==pos})
    }

    method iniciarSigNivel() {
        obstaculos.clear() // mejor en terminar nivel
        
        const actual = niveles.first()
        actual.inicializar()
        niveles.remove(actual)
        
        hudVisible.dibujar()
        juego.estado(jugando)
        juego.persecucion()
    }

    method terminarNivel() {

    }

/*
    method incrementarEnemigos() {
        enemigosDerrotados += 1
        self.revisarNivel()
    }

    method revisarNivel() {
        if (enemigosDerrotados >= enemigosPorNivel) {
            enemigosDerrotados = 0
            nivelActual += 1
            self.cambiarNivel()
            enemigosPorNivel += 5
        }
    }
*/

}

//Idea: Entre cada nivel aparece la tienda para poder mejorar el Arma/Salud/Energia
//El primer nivel debe ser una pantalla donde presete el juego
//Luego una pantalla donde este el menu y se seleccione el personaje


class Nivel {

    const img
    const enemigos
    method tablero() 

    method inicializar() {
         suelo.visualizarCon(img)

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
                self.tablero().get(y).get(x).dibujarEn(game.at(x,y))
            })
        })
    }
}

object _ {
    method dibujarEn(pos) {}
}

//caja
object c {
    method dibujarEn(pos) {
        const cajaNueva = new Caja(position=pos)
        game.addVisual(cajaNueva)
        nivelManager.obstaculos().add(cajaNueva)
    }
}

class Caja {
    var property image = "caja2.png"
    var property position
}


