Class AOC2021.Day4 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d4.txt";

// w ##class(AOC2021.Day4).Run1()

ClassMethod check(
	ByRef game,
	ByRef winners) As %Integer
{
    for gg = 1:1:game {
	    i $d(game(gg,"win")) continue
	    for rr=1:1:5 {
		    for cc=1:1:5 {
			    set turn=$o(game(gg,rr,cc,""))
			    if turn = "" q
			    //if z=game(gg,rr,cc) {
				//    set game(gg,rr,cc,turn)=z
			    //}
			    if cc=5 {
				    set game(gg,"win")=turn
				    set winners = $G(winners,0)+1
				    set winners(winners)=gg
			    }
		    }
		    if $d(game(gg,"win")) q
	    }
	    //if $d(game(gg,"win")) q
    }
    //if $d(game(gg,"win")) q gg


    for gg = 1:1:game {
	    i $d(game(gg,"win")) continue
	    for cc=1:1:5 {
		    for rr=1:1:5 {
			    set turn=$o(game(gg,rr,cc,""))
			    if turn = "" q
			    //if z=game(gg,rr,cc) {
				//    set game(gg,rr,cc,turn)=z
			    //}
			    if rr=5 {
				    set game(gg,"win")=turn
				    set winners = $G(winners,0)+1
				    set winners(winners)=gg
			    }
		    }
		    if $d(game(gg,"win")) q
	    }
	    //if $d(game(gg,"win")) q
    }
    if $d(game(gg,"win")) q gg
	Quit 0
}

ClassMethod Run1(verbose = 1) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set game=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		if (previous<0) {
			for ii=1:1:$L(line,",") set rnum(ii)=$P(line,",",ii) set max=ii
			s previous=1
			continue
		}
		if (line="") set game=game+1 s row=0 continue
		s row=row+1
		f ii=1:1:5 {
			s x=$E(line,(ii-1)*3,(ii-1)*3+2)
			while $E(x,1)=" " {
				s x=$E(x,2,*)
			}
			set game(game,row,ii) = +x
		} 
		set previous=line
        if verbose write "line="_line,!
        continue
    }
    zw game
    f turn=1:1:max {
    	s z=rnum(turn)

    for gg = 1:1:game {
	    for cc=1:1:5 {
		    for rr=1:1:5 {
			    set t=$g(game(gg,rr,cc))
			    if t'=z continue
				    set game(gg,rr,cc,turn)=z
			    
		    }
	    }
    }


    	s win=..check(.game,.winners)
    	i win w turn,!
    	i win quit
    }
    s sum=0
    for rr=1:1:5 {
	    for cc=1:1:5 {
			    set turn=$o(game(win,rr,cc,""))
			    if turn = "" s sum=sum+game(win,rr,cc)
	    }
    } 
    
    return z*sum
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set game=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		if (previous<0) {
			for ii=1:1:$L(line,",") set rnum(ii)=$P(line,",",ii) set max=ii
			s previous=1
			continue
		}
		if (line="") set game=game+1 s row=0 continue
		s row=row+1
		f ii=1:1:5 {
			s x=$E(line,(ii-1)*3,(ii-1)*3+2)
			while $E(x,1)=" " {
				s x=$E(x,2,*)
			}
			set game(game,row,ii) = +x
		} 
		set previous=line
        if verbose write "line="_line,!
        continue
    }
    zw game
    s winners=0
    f turn=1:1:max {
    	s z=rnum(turn)

    for gg = 1:1:game {
	    for cc=1:1:5 {
		    for rr=1:1:5 {
			    set t=$g(game(gg,rr,cc))
			    if t'=z continue
				    set game(gg,rr,cc,turn)=z
			    
		    }
	    }
    }


    	s win=..check(.game,.winners)
    	i winners=100 w turn,! quit
    }
    s win=winners(100)
    s sum=0
    for rr=1:1:5 {
	    for cc=1:1:5 {
			    set turn=$o(game(win,rr,cc,""))
			    if turn = "" s sum=sum+game(win,rr,cc)
	    }
    } 
    zw winners
    return z*sum
}

}
