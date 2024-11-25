import wollok.game.*
import posiciones.*
import hud.*
import managers.*


class Personaje { 
    //Imagen y posicion
    var property image = self.imagenInicial()
    var property position = game.at(5,5)
    //Estadisticas
    var property oro = 9999
    //Propiedades   
    var property arma 
    
    method visualAmmo()
    method imagenInicial()
    method imagenNormal(dir)
    method imagenAtaque(dir)
    method sonidoAtaque()
    method cura(num)
    method sinMunicion()
    method lanzarEspecial() 


    method visualHealth(numero) {
        return self.cura(numero)
    }
    
    // -------------movimiento-------------------------------
    
    method mover(direccion) {
        barraDeEnergia.validarEnergia()
        self.validarMover(direccion)
	    position = direccion.siguientePosicion(position)
        self.image(self.imagenNormal(direccion))
        managerItems.revisarPorItems(position)
	}

    method validarMover(direccion) {
		const siguiente = direccion.siguientePosicion(position)
		tablero.validarDentro(siguiente)
        self.validarNoHayEnemigos(siguiente)
	}

    method validarNoHayEnemigos(posicion) {
        if(managerZombie.posTieneZombie(posicion)) {
            self.error("")
        }
    }

    // -------------ataque-------------------------------
    
    method ataque(direccion) { 
        self.image(self.imagenNormal(direccion))
        arma.validarAtaque()
        arma.gatillar(direccion,position)                                             
    }
    
    method animacionAtaque(direccion) {                                                       
        self.image(self.imagenAtaque(direccion))
        game.schedule(300,{self.image(self.imagenNormal(direccion))})
        self.sonidoAtaque()
    }

    // -------------items-------------------------------

    method herir(cantidad) {
        puntosDeVida.herir(cantidad)
    }

    method obtenerOro(valor) {
        game.sound("oro-sonido.mp3").play()
        oro = (oro + valor).min(999)
    }

    method restarOro(valor){
        oro = (oro-valor).max(0)
    }

}

