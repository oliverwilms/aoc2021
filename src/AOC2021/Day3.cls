Class AOC2021.Day3 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d3.txt";

// w ##class(AOC2021.Day2).Run1()

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set h = 0
	set cnt=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		s cnt=cnt+1
		for ii=1:1:$L(line) {
			if $E(line,ii) set cnt(ii)=$G(cnt(ii),0)+1
		}
        //if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    for ii=1:1:$L(line) {
	    s g(ii)=0
	    if (cnt(ii) > (cnt/2)) s g(ii)=1
    }
    zw g
    s gamma=0
    s delta = 1
    f ii=$l(line):-1:1 {
	     i g(ii) set gamma=gamma+delta
	     s delta=delta*2
    }
    s ep=0
    s delta = 1
    f ii=$l(line):-1:1 {
	     i (g(ii)=0) set ep=ep+delta
	     s delta=delta*2
    }
    return gamma*ep
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set ox = 0
	set cnt=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		s cnt=cnt+1
		s keep(cnt)=line
		for ii=1:1:$L(line) {
			if $E(line,ii) set cnt(ii)=$G(cnt(ii),0)+1
		}
        //if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    m cnt2 = cnt
    m keep2 = keep
    zw cnt
    s half=cnt/2
    s keep=0
    s kcnt=cnt
    for ii=1:1:$L(line) {
	    s keep=0
	    s digits=0
	    for {
		    s keep = $O(keep(keep)) i keep="" q
		    i $E(keep(keep),ii) s digits=digits+1
	    }
	    s target=1
	    i ((kcnt - digits) > digits) s target = 0
	    for {
		    s keep = $O(keep(keep)) i keep="" q
		    if $e(keep(keep),ii)'=target kill keep(keep) s kcnt=kcnt-1 i kcnt=1 q
	    }
	    i kcnt=1 s keep=$O(keep("")) s ox=keep(keep) zw ox q
    }
	k cnt
	set cnt=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		s cnt=cnt+1
		s keep(cnt)=line
		for ii=1:1:$L(line) {
			if $E(line,ii) set cnt(ii)=$G(cnt(ii),0)+1
		}
        //if verbose write "line="_line," ","sum="_sum,!
        continue
    }
	m cnt=cnt2
	m keep=keep2
    s keep=0
    s kcnt=cnt
    for ii=1:1:$L(line) {
	    s keep=0
	    s digits=0
	    for {
		    s keep = $O(keep(keep)) i keep="" q
		    i ($E(keep(keep),ii)=1) s digits=digits+1
	    }
	    s target=0
	    i ((kcnt - digits) > digits) s target = 1
	    for {
		    s keep = $O(keep(keep)) i keep="" q
		    if $e(keep(keep),ii)'=target kill keep(keep) s kcnt=kcnt-1 i kcnt=1 q
	    }
	    i kcnt=1 s keep=$O(keep("")) s co=keep(keep) zw co q
		    
    }

    zw keep
    
    s gamma=0
    s coma=0
    s delta = 1
    f ii=$l(line):-1:1 {
	     i $e(ox,ii) set gamma=gamma+delta
	     i $e(co,ii) set coma=coma+delta
	     s delta=delta*2
    }
    w "ox = ",gamma,!
    w "co = ",coma,!
    return gamma*coma
    s ep=0
    s delta = 1
    f ii=$l(line):-1:1 {
	     i (g(ii)=0) set ep=ep+delta
	     s delta=delta*2
    }
    return gamma*ep
}

}
