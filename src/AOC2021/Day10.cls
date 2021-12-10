Class AOC2021.Day10 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d10.txt";

Parameter TestFile = "aoc2021d10test.txt";

// w ##class(AOC2021.Day10).Run1()

ClassMethod Run1(verbose = 0) As %Integer
{
	//set stream=..GetInput(..#TestFile)
		set stream=..GetInput(..#InputFile)

	set sum=0
	set aaa=-1
	set bbb=-1
	set compare=-1
	set open(1)="(",close(1)=")",illegal(1)=3
	set open(2)="[",close(2)="]",illegal(2)=57
	set open(3)="{",close(3)="}",illegal(3)=1197
	set open(4)="<",close(4)=">",illegal(4)=25137
	for ii=1:1:4 {
		set open=$G(open)_open(ii)
		set close=$G(close)_close(ii)
		set illegal=$G(illegal)_illegal(ii)
	}
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set ccc=line
		set value=aaa+bbb+ccc
		set aaa=bbb
		set bbb=ccc
        s test=..testLine(line)
        s sum=sum+test
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return sum
}

ClassMethod Run2(verbose = 0) As %Integer
{
	//set stream=..GetInput(..#TestFile)
		set stream=..GetInput(..#InputFile)

	set sum=0
	set aaa=-1
	set bbb=-1
	set compare=-1
	set open(1)="(",close(1)=")",illegal(1)=3
	set open(2)="[",close(2)="]",illegal(2)=57
	set open(3)="{",close(3)="}",illegal(3)=1197
	set open(4)="<",close(4)=">",illegal(4)=25137
	for ii=1:1:4 {
		set open=$G(open)_open(ii)
		set close=$G(close)_close(ii)
		set illegal=$G(illegal)_illegal(ii)
	}
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set ccc=line
		set value=aaa+bbb+ccc
		set aaa=bbb
		set bbb=ccc
        s test=..testLine2(line)
        if test=0 continue
        s scores(test,ccc)=test
        s scores=$G(scores,0)+1
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    set middle=scores/2
    set x=""
    for {
	    set x=$Order(scores(x))
	    set count=$G(count,0)+1
	    If count>middle set sum=x quit
    }	   
    return sum
}

ClassMethod Test(verbose = 1) As %Integer
{
	//set stream=..GetInput(..#TestFile)
		set stream=..GetInput(..#InputFile)

	set sum=0
	set aaa=-1
	set bbb=-1
	set compare=-1
	set open(1)="(",close(1)=")",illegal(1)=3
	set open(2)="[",close(2)="]",illegal(2)=57
	set open(3)="{",close(3)="}",illegal(3)=1197
	set open(4)="<",close(4)=">",illegal(4)=25137
	for ii=1:1:4 {
		set open=$G(open)_open(ii)
		set close=$G(close)_close(ii)
		set illegal=$G(illegal)_illegal(ii)
	}
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set ccc=line
		set value=aaa+bbb+ccc
		set aaa=bbb
		set bbb=ccc
        s test=..testLine(line)
        s sum=sum+test
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return sum
}

ClassMethod testLine(pLine As %String) As %Integer
{
			set isIllegal=0
	set open(1)="(",close(1)=")",illegal(1)=3
	set open(2)="[",close(2)="]",illegal(2)=57
	set open(3)="{",close(3)="}",illegal(3)=1197
	set open(4)="<",close(4)=">",illegal(4)=25137
	for ii=1:1:4 {
		set open=$G(open)_open(ii)
		set close=$G(close)_close(ii)
		set illegal=$G(illegal)_illegal(ii)
	}
	set z=$L(pLine)
	for ii=1:1:z {
		set e=$E(pLine,ii)
		if e=open(1) set stack=$G(stack)_1 continue
		if e=open(2) set stack=$G(stack)_2 continue
		if e=open(3) set stack=$G(stack)_3 continue
		if e=open(4) set stack=$G(stack)_4 continue
		if close[e {
			set jj=$E(stack,*),stack=$E(stack,1,*-1)
			if e=close(jj) continue
			set isIllegal=1
			quit
		}
	}
	if isIllegal {
		if e=close(1) quit illegal(1)
		if e=close(2) quit illegal(2)
		if e=close(3) quit illegal(3)
		if e=close(4) quit illegal(4)
	}
	if $L(stack) quit 0 // 0-$L(stack)
	quit 0
}

ClassMethod testLine2(pLine As %String) As %Integer
{
			set isIllegal=0
	set open(1)="(",close(1)=")",illegal(1)=3
	set open(2)="[",close(2)="]",illegal(2)=57
	set open(3)="{",close(3)="}",illegal(3)=1197
	set open(4)="<",close(4)=">",illegal(4)=25137
	for ii=1:1:4 {
		set open=$G(open)_open(ii)
		set close=$G(close)_close(ii)
		set illegal=$G(illegal)_illegal(ii)
	}
	set z=$L(pLine)
	for ii=1:1:z {
		set e=$E(pLine,ii)
		if e=open(1) set stack=$G(stack)_1 continue
		if e=open(2) set stack=$G(stack)_2 continue
		if e=open(3) set stack=$G(stack)_3 continue
		if e=open(4) set stack=$G(stack)_4 continue
		if close[e {
			set jj=$E(stack,*),stack=$E(stack,1,*-1)
			if e=close(jj) continue
			set isIllegal=1
			quit
		}
	}
	if isIllegal quit 0
	/*
	if isIllegal {
		if e=close(1) quit illegal(1)
		if e=close(2) quit illegal(2)
		if e=close(3) quit illegal(3)
		if e=close(4) quit illegal(4)
	}
	*/
	set score=0
	set z=$L(stack)
	for ii=1:1:z {
		set e=$E(stack,*),stack=$E(stack,1,*-1)
		//if e = close(1) set auto=1
		//if e = close(2) set auto=2
		//if e = close(3) set auto=3
		//if e = close(4) set auto=4
		set score = score * 5 + e
	}
	quit score
	if $L(stack) quit 0 // 0-$L(stack)
	quit 0
}

}
