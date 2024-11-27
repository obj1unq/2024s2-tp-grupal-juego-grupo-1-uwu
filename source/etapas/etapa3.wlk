import wollok.game.*
import nivelManager.*

/*
object niv5 inherits Nivel(enemigos=6,img="suelo-castllo.png",ost=game.sound("musica-nivel-3.mp3")) {
    override method tablero() {
    return
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,c,c,c,c,c,c,_,_,_,c,c,c,c,c,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse() 
    }
}
*/

object niv6 inherits Nivel(enemigos=7,img="suelo-castllo.png",ost=game.sound("musica-nivel-1.mp3")) {
    override method tablero() {
    return
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,p,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m,p,_],     
     [_,_,_,_,_,c,_,_,_,_,_,_,_,_,c,_,_,_,p,_],     
     [_,_,_,_,c,c,c,_,_,_,_,_,_,c,c,c,_,_,_,_],     
     [p,_,_,_,_,c,_,_,_,_,_,_,_,_,c,_,_,_,_,_],     
     [p,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [m,m,_,_,_,_,_,_,_,_,m,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_,_,m,m,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m,m,_],
     [_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_],
     [_,_,_,_,_,c,c,c,c,c,c,c,c,c,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,p,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse() 
    }
}