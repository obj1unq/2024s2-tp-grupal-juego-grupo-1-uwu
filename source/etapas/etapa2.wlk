import wollok.game.*
import nivelManager.*


object niv3 inherits Nivel(enemigos=6,img="suelo-casa.png") {
    override method tablero() {
    return
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,c,c,c,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,c,c,c,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse() 
    }
}

object niv4 inherits Nivel(enemigos=7,img="suelo-casa.png") {
    override method tablero() {
    return
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,c,c,c,_,_,c,c,c,c,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,c,c,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,c,c,c,_,_,_,_,c,c,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse() 
    }
}