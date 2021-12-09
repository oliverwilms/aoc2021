Class AOC2021.Day9 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d9.txt";

// w ##class(AOC2021.Day9).Run1()

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set risk=0
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		s y=y+1
		s z=$l(line)
		f x=1:1:z {
			s grid(x,y) = $E(line,x)
		}
		set yy=y
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
		for y=1:1:yy {
			for x=1:1:z {
				if $d(grid(x,y-1)) if grid(x,y)'<grid(x,y-1) continue
				if $d(grid(x,y+1)) if grid(x,y)'<grid(x,y+1) continue
				if $d(grid(x+1,y)) if grid(x,y)'<grid(x+1,y) continue
				if $d(grid(x-1,y)) if grid(x,y)'<grid(x-1,y) continue
				s low(x,y) = grid(x,y)
				s risk = risk + 1 + grid(x,y)
			}
		}
    return risk
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set risk=0
	set y=0
	while 'stream.AtEnd {
	/*
	for yy=1:1:5 {
		if yy=1 set line="2199943210"
		if yy=2 set line="3987894921"
		if yy=3 set line="9856789892"
		if yy=4 set line="8767896789"
		if yy=5 set line="9899965678"
		*/
		set line=stream.ReadLine()
		s y=y+1
		s yy=y
		s z=$l(line)
		f x=1:1:z {
			s grid(yy,x) = $E(line,x)
		}
		//set yy=y
        continue
    }
    do ..showGrid(.grid)
		set grid(0)=yy_","_z
    	set basin=0
		for y=1:1:yy {
			for x=1:1:z {
				if y>1 if grid(y,x)'<grid(y-1,x) continue
				if y<yy if grid(y,x)'<grid(y+1,x) continue
				if x<z if grid(y,x)'<grid(y,x+1) continue
				if x>1 if grid(y,x)'<grid(y,x-1) continue
				set basin=basin+1
				set basin(y,x)=basin
				set basin(basin)=$g(basin(basin),0)+1
				s low(basin) = y_","_x
				s risk = risk + 1 + grid(y,x)
			}
		}
		zw basin
		
		zw low
	set basins=basin 
	for bb = 1:1:basins do ..growBasin(.grid,.basin,.low,bb)
	
	zw basin
	
	set row=""
	for row=1:1 {
		set col=$Order(basin(row,"")) if col="" quit
		for {
			s basin=basin(row,col)
			s basinsize(basin) = $Get(basinsize(basin),0)+1
			set col=$Order(basin(row,col)) if col="" w ! quit
		}
	}
	zw basinsize
	for basin=1:1:basins {
		set basinsize = basinsize(basin)
		set sizes(0-basinsize,basin) = basinsize
	}
	set cnt=0
	set bb=""
	for {
		set bb = $Order(sizes(bb)) if bb="" quit
		set cc = ""
		for {
			set cc = $Order(sizes(bb,cc)) if cc="" quit
			set cnt=cnt+1
			if cnt>3 quit
			set cnt(cnt) = sizes(bb,cc)
		}
		if cnt>3 quit
	}
	quit cnt(1)*cnt(2)*cnt(3)

	
	set stream=..GetInput(..#InputFile)
	set risk=0
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		s y=y+1
		s z=$l(line)
		f x=1:1:z {
			s grid(y,x) = $E(line,x)
		}
		set yy=y
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    	set basin=0
		for y=1:1:yy {
			for x=1:1:z {
				if $d(grid(x,y-1)) if grid(x,y)'<grid(x,y-1) continue
				if $d(grid(x,y+1)) if grid(x,y)'<grid(x,y+1) continue
				if $d(grid(x+1,y)) if grid(x,y)'<grid(x+1,y) continue
				if $d(grid(x-1,y)) if grid(x,y)'<grid(x-1,y) continue
				set basin=basin+1
				set basin(x,y)=basin
				set basin(basin)=$g(basin(basin),0)+1
				s low(basin) = y_","_x
				s risk = risk + 1 + grid(x,y)
			}
		}
 
	for bb = 1:1:basin do ..growBasin(.grid,.basin,.low,bb)
    return risk
}

ClassMethod growBase(
	ByRef grid,
	ByRef basin,
	y,
	x,
	bb)
{
	if grid(y,x)=9 quit
	set basin(y,x) = bb
	set pos=grid(0)
	set yy = $P(pos,",",1)
	set xx = $P(pos,",",2)
	if y>1 if grid(y,x)<grid(y-1,x) do ..growBase(.grid,.basin,y-1,x,bb)
	if y<yy if grid(y,x)<grid(y+1,x) do ..growBase(.grid,.basin,y+1,x,bb)
	if x<xx if grid(y,x)<grid(y,x+1) do ..growBase(.grid,.basin,y,x+1,bb)
	if x>1 if grid(y,x)<grid(y,x-1) do ..growBase(.grid,.basin,y,x-1,bb)
	quit

				if $d(grid(x,y-1)) do ..growBase(.grid,.basin,y,x)
				if $d(grid(x,y+1)) do ..growBase(.grid,.basin,y,x)
				if $d(grid(x+1,y)) do ..growBase(.grid,.basin,y,x)
				if $d(grid(x-1,y)) do ..growBase(.grid,.basin,y,x) 
	quit
}

ClassMethod growBasin(
	ByRef grid,
	ByRef basin,
	ByRef low,
	bb)
{
	set pos=low(bb)
	set y = $P(pos,",",1)
	set x = $P(pos,",",2)
	do ..growBase(.grid,.basin,y,x,bb)
	quit
				if $d(grid(x,y-1)) do ..growBase(.grid,.basin,y,x)
				if $d(grid(x,y+1)) do ..growBase(.grid,.basin,y,x)
				if $d(grid(x+1,y)) do ..growBase(.grid,.basin,y,x)
				if $d(grid(x-1,y)) do ..growBase(.grid,.basin,y,x) 
	quit
}

ClassMethod showGrid(ByRef grid)
{
	for row=1:1 {
		set col=$Order(grid(row,"")) if col="" quit
		w grid(row,col)
		for {
			set col=$Order(grid(row,col)) if col="" w ! quit
		}
	}
	quit
}

ClassMethod Test(verbose = 0) As %Integer
{
	//set stream=..GetInput(..#InputFile)
	set risk=0
	set y=0
	//while 'stream.AtEnd {
	for yy=1:1:5 {
		if yy=1 set line="2199943210"
		if yy=2 set line="3987894921"
		if yy=3 set line="9856789892"
		if yy=4 set line="8767896789"
		if yy=5 set line="9899965678"
		//set line=stream.ReadLine()
		s y=yy
		s z=$l(line)
		f x=1:1:z {
			s grid(yy,x) = $E(line,x)
		}
		//set yy=y
        continue
    }
    do ..showGrid(.grid)
		set grid(0)=yy_","_z
    	set basin=0
		for y=1:1:yy {
			for x=1:1:z {
				if y>1 if grid(y,x)'<grid(y-1,x) continue
				if y<yy if grid(y,x)'<grid(y+1,x) continue
				if x<z if grid(y,x)'<grid(y,x+1) continue
				if x>1 if grid(y,x)'<grid(y,x-1) continue
				set basin=basin+1
				set basin(y,x)=basin
				set basin(basin)=$g(basin(basin),0)+1
				s low(basin) = y_","_x
				s risk = risk + 1 + grid(y,x)
			}
		}
		zw basin
		
		zw low
	set basins=basin 
	for bb = 1:1:basins do ..growBasin(.grid,.basin,.low,bb)
	
	zw basin
	
	set row=""
	for row=1:1 {
		set col=$Order(basin(row,"")) if col="" quit
		for {
			s basin=basin(row,col)
			s basinsize(basin) = $Get(basinsize(basin),0)+1
			set col=$Order(basin(row,col)) if col="" w ! quit
		}
	}
	zw basinsize
	for basin=1:1:basins {
		set basinsize = basinsize(basin)
		set sizes(0-basinsize,basin) = basinsize
	}
	set cnt=0
	set bb=""
	for {
		set bb = $Order(sizes(bb)) if bb="" quit
		set cc = ""
		for {
			set cc = $Order(sizes(bb,cc)) if cc="" quit
			set cnt=cnt+1
			if cnt>3 quit
			set cnt(cnt) = sizes(bb,cc)
		}
		if cnt>3 quit
	}
	quit cnt(1)*cnt(2)*cnt(3)

    for row=1:1:yy {
	    for col=1:1:z {
		    if row=1 set basin=1
		    if grid(row,col)<9 set basin(basin)=$G(basin(basin),0)+1
	    }
    }
    quit 0
    	set basin=1
		for y=1:1:yy {
			for x=1:1:z {
				if $d(grid(x+1,y)) if grid(x+1,y)=9 quit
				set basin(x,y)=basin
				set basin(basin)=$g(basin(basin),0)+1
				if $d(grid(x,y+1)) if grid(x,y)'<grid(x,y+1) continue
				if $d(grid(x+1,y)) if grid(x,y)'<grid(x+1,y) continue
				if $d(grid(x-1,y)) if grid(x,y)'<grid(x-1,y) continue
				s low(x,y) = grid(x,y)
				s risk = risk + 1 + grid(x,y)
			}
		}
    return risk
}

}
