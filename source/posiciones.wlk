import wollok.game.*

object arriba {
  method siguientePosicion(position) = position.up(1)
}

object izquierda {
  method siguientePosicion(position) = position.left(1)
}

object abajo {
  method siguientePosicion(position) = position.down(1)
}

object derecha {
  method siguientePosicion(position) = position.right(1)
}

object tablero {
  method validarDentro(position) {
    if (not self.estaDentro(position)) {
      self.error("No puedo moverme fuera del tablero")
    }
  }
  
  method estaDentro(position) { 
    return position.x().between(0, game.width() - 1) and 
      position.y().between(0, game.height() - 2) 
  }

  method verticalesDe(pos) {
      return #{abajo.siguientePosicion(pos), arriba.siguientePosicion(pos),
            izquierda.siguientePosicion(pos), derecha.siguientePosicion(pos)}
  }

  method alrededoresDe(position) {
        return #{abajo.siguientePosicion(position), arriba.siguientePosicion(position),
            izquierda.siguientePosicion(position), derecha.siguientePosicion(position),
            abajo.siguientePosicion(izquierda.siguientePosicion(position)), abajo.siguientePosicion(derecha.siguientePosicion(position)),
            arriba.siguientePosicion(izquierda.siguientePosicion(position)), arriba.siguientePosicion(derecha.siguientePosicion(position))}
    }

  method posicionRandom() {
        return (game.at(0.randomUpTo(game.width() - 1).round(), 0.randomUpTo(game.height() - 2).round()))
    }
}
