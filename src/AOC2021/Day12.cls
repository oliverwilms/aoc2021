Class AOC2021.Day12 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d12.txt";

Parameter TestFile = "aoc2021d12test.txt";

// w ##class(AOC2021.Day12).Run1()

ClassMethod isLower(a As %String) As %Status
{
	Set la = $ASCII("a")
	Set lz = $ASCII("z")
	Set e = $Extract(a,1)
	If $ASCII(e)>=la,($ASCII(e)<=lz) Quit 1
	Quit 0
}

ClassMethod Sub(
	ByRef p,
	ByRef c) As %Status
{
    
    set b=""
    set pp=0
    set done=1
    For {
	    set pp = $O(p(pp)) if pp="" quit
	    set a=$P(p(pp),",",*)
	    if a = "end" continue
	    set b=""
	    set q=0
	    for {
		    set b = $O(c(a,b)) if b="" quit
		    if b = "start" continue
		    if ..isLower(b),$G(p(pp,b),0) continue
		    set q=q+1
		    set done=0
		    if q=1 set p(pp)=p(pp)_","_b,p(pp,b)=$G(p(pp,b),0)+1

		    if q>1 {
			    set path=p(pp),psave=pp,pp=$I(p),p(pp)=path,$P(p(pp),",",*)=b
			    for ii=2:1 {
				    set bb = $P(p(pp),",",ii)
				    if bb="" quit
				    set p(pp,bb)=$G(p(pp,bb),0)+1
			    }
		    }
			if q>1 set pp=psave
	    }
    }
    zw p
	Quit done
}

ClassMethod Sub2(
	ByRef p,
	ByRef c) As %Status
{
    
    set b=""
    set pp=0
    set done=1
    For {
	    set pp = $O(p(pp)) if pp="" quit
	    set a=$P(p(pp),",",*)
	    if a = "end" continue
	    set b=""
	    set q=0
	    for {
		    set b = $O(c(a,b)) if b="" quit
		    if b = "start" continue
		    set blast=$P(p(pp),",",*)
		    if ..isLower(b),$Get(p(pp,"twice"))'="",$Get(p(pp,"twice"))'=blast,$G(p(pp,b),0) continue
		    set q=q+1
		    set done=0
		    if q=1 set p(pp)=p(pp)_","_b,p(pp,b)=($G(p(pp,b),0)+1) if ..isLower(b),(p(pp,b)>1) set p(pp,"twice")=b


		    if q>1 {
			    set path=p(pp),psave=pp,pp=$I(p),p(pp)=path,$P(p(pp),",",*)=b
			    for ii=2:1 {
				    set bb = $P(p(pp),",",ii)
				    if bb="" quit
				    set p(pp,bb)=($G(p(pp,bb),0)+1)
				    if ..isLower(bb),(p(pp,bb)>1) set p(pp,"twice")=bb

			    }
			    
				//if ..isLower(b),(p(pp,b)>1) set p(pp,"twice")=b
		    }
			if q>1 set pp=psave
	    }
	    if q=0 kill p(pp)
    }
    //zw p
	Quit done
}

ClassMethod Run1(verbose = 0) As %Integer
{
	//set stream=..GetInput(..#TestFile)

	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set a=$P(line,"-",1)
		set b=$P(line,"-",2)
		set c(a,b)=1
		
		set c(b,a)=1
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    zw c
    set a = "start"
    set b=""
    set p=0
    For {
	    set b = $O(c(a,b)) if b="" quit
	    set p=p+1
	    set p(p)=a_","_b
	    set p(p,b)=$G(p(p,b),0)+1
    }
    zw p
    for {
	    set done = ..Sub(.p,.c)
	    if done quit
    }
    for pp=1:1:p {
	    if $P(p(pp),",",*)="end" set sum=sum+1
    }
    return sum
}

ClassMethod Run2(verbose = 0) As %Integer
{
	//set stream=..GetInput(..#TestFile)

	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set a=$P(line,"-",1)
		set b=$P(line,"-",2)
		set c(a,b)=1
		
		set c(b,a)=1
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    zw c
    set a = "start"
    set b=""
    set p=0
    For {
	    set b = $O(c(a,b)) if b="" quit
	    set p=p+1
	    set p(p)=a_","_b
	    set p(p,b)=$G(p(p,b),0)+1
    }
    zw p
    for {
	    set done = ..Sub2(.p,.c)
	    if done quit
    }
    set pp=""
    for {
	    set pp=$O(p(pp)) if pp="" quit
	    if $P(p(pp),",",*)="end" set sum=sum+1
    }
    /*for pp=1:1:p {
	    set path = p(pp)
	    for qq = 1:1:(pp-1) {
		    if p(qq) = path set sum=sum-1
	    }
    }*/
    quit sum
    for pp=1:1:p {
	    set path=p(pp)
	    set qq(path)=pp
	   
    }
    set path=""
    for {
	    set path=$O(qq(path))
	    if path="" quit
	    write path,!
    }
    return sum
}

}
