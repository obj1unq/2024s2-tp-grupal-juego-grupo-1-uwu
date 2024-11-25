import wollok.game.*
import nivelManager.*


object niv5 inherits Nivel(enemigos=6,img="suelo-castillo.png") {
    override method tablero() {
    return
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,c,c,c,c,c,c,_,_,_,c,c,c,c,c,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse() 
    }
}

object niv6 inherits Nivel(enemigos=7,img="suelo-castillo.png") {
    override method tablero() {
    return
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,c,c,c,_,_,_,_,_,_,c,c,c,_,_,_,_],     
     [_,_,_,_,c,c,c,_,_,_,_,_,_,c,c,c,_,_,_,_],     
     [_,_,_,_,c,c,c,_,_,_,_,_,_,c,c,c,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_],
     [_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_],
     [_,_,_,_,_,c,c,c,c,c,c,c,c,c,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse() 
    }
}