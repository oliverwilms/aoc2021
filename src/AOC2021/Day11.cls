Class AOC2021.Day11 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d11.txt";

Parameter TestFile = "aoc2021d10test.txt";

// w ##class(AOC2021.Day11).Run1()

ClassMethod Flash1(
	ByRef grid,
	x As %Integer,
	y As %Integer) As %Integer
{
	set flash=$G(grid(y,x,"flash"),0)
	if flash=grid quit
	set grid(y,x,"flash")=grid
	set grid("flash",grid)=$G(grid("flash",grid),0)+1
	set grid("flash")=$G(grid("flash"),0)+1
	if y>1 set level=grid(y-1,x)+1 set grid(y-1,x)=level if level>9 do ..Flash1(.grid,x,y-1)
	if y>1,(x>1) set level=grid(y-1,x-1)+1 set grid(y-1,x-1)=level if level>9 do ..Flash1(.grid,x-1,y-1)
	if y>0,(x>1) set level=grid(y-0,x-1)+1 set grid(y-0,x-1)=level if level>9 do ..Flash1(.grid,x-1,y-0)
	if y<10,(x>1) set level=grid(y+1,x-1)+1 set grid(y+1,x-1)=level if level>9 do ..Flash1(.grid,x-1,y+1)
	if y<10,(x>0) set level=grid(y+1,x-0)+1 set grid(y+1,x-0)=level if level>9 do ..Flash1(.grid,x-0,y+1)
	if y<10,(x<10) set level=grid(y+1,x+1)+1 set grid(y+1,x+1)=level if level>9 do ..Flash1(.grid,x+1,y+1)
	if y>0,(x<10) set level=grid(y+0,x+1)+1 set grid(y+0,x+1)=level if level>9 do ..Flash1(.grid,x+1,y+0)
	if y>1,(x<10) set level=grid(y-1,x+1)+1 set grid(y-1,x+1)=level if level>9 do ..Flash1(.grid,x+1,y-1)
	quit 0
}

ClassMethod Step1(ByRef grid) As %Integer
{
	s sum=0
	for y=1:1:10 {
		set z=10
		for x=1:1:z {
			set grid(y,x)=grid(y,x)+1
		}
	}
	for y=1:1:10 {
		for x=1:1:z {
			set level=grid(y,x)
			if level>9 {
				
				do ..Flash1(.grid,x,y)
			}
		}
        continue
    }
	for y=1:1:10 {
		set z=10
		for x=1:1:z {
			set flash=$G(grid(y,x,"flash"),0)
			if flash=grid set grid(y,x)=0
		}
	}
    //zw grid
    quit
}

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set y=1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set z=$L(line)
		for x=1:1:z set grid(y,x)=$E(line,x)
		s y=y+1
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    zw grid
    for step=1:1:100 {
	    set grid=step
	    do ..Step1(.grid)
    }
    return grid("flash")
    return sum
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set y=1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set z=$L(line)
		for x=1:1:z set grid(y,x)=$E(line,x)
		s y=y+1
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    zw grid
    for step=1:1 {
	    set grid=step
	    do ..Step1(.grid)
	    set sum=..Test(.grid)
	    if sum quit
    }
    return step
    return grid("flash")
}

ClassMethod Test(ByRef grid) As %Integer
{
	s sum=0
	for y=1:1:10 {
		set z=10
		for x=1:1:z {
			set flash=$G(grid(y,x,"flash"),0)
			if flash=grid set sum=sum+1
		}
	}


    return (sum=100)
}

}
