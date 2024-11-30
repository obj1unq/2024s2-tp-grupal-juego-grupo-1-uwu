import wollok.game.*
import nivelManager.*


object niv4 inherits Nivel(enemigos=13,img="suelo-laboratorio.png",ost=game.sound("musica-nivel-3.mp3")) {
    override method tablero() {
    return
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,c,_,c,_,_,c,_,c,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,c,_,_,_,_,c,c,_,_,_,_,c,_,_,_,_],     
     [_,_,_,_,_,_,c,_,_,_,_,_,_,c,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,c,_,_,_,_,_,_,c,_,_,_,_,_,_],
     [_,_,_,_,c,_,_,_,_,c,c,_,_,_,_,c,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,c,_,c,_,_,c,_,c,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse() 
    }
}
