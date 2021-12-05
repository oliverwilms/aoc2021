Class AOC2021.Day5 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d5.txt";

// w ##class(AOC2021.Day5).Run1()

ClassMethod Run1(verbose = 1) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set x1 = $P(line,",",1)
		set rest = $P(line,",",2,*)
		set y1 = $P(rest," ",1)
		set r2 = $P(line," ",3)
		set x2 = $P(r2,",",1)
		set y2 = $P(r2,",",2)
		if (x1 = x2) {
			for ii = y1:1:y2 {
				set cover(x1,ii) = $G(cover(x1,ii),0)+1
			}
			for ii = y2:1:y1 {
				set cover(x1,ii) = $G(cover(x1,ii),0)+1
			}
		}
		if (y1 = y2) {
			for ii = x1:1:x2 {
				set cover(ii,y1) = $G(cover(ii,y1),0)+1
			}
			for ii = x2:1:x1 {
				set cover(ii,y1) = $G(cover(ii,y1),0)+1
			}
		}
		
	}
	set x=""
	for {
		set x = $O(cover(x)) if x = "" q
		set y = ""
		for {
			set y = $O(cover(x,y)) if y="" q
			if $g(cover(x,y)) > 1 s sum=sum+1 
		}
	}
	quit sum
}

ClassMethod Run2(verbose = 1) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set x1 = $P(line,",",1)
		set rest = $P(line,",",2,*)
		set y1 = $P(rest," ",1)
		set r2 = $P(line," ",3)
		set x2 = $P(r2,",",1)
		set y2 = $P(r2,",",2)
		set done=0
		if (x1 = x2),(y1<y2) {
			for ii = y1:1:y2 {
				set cover(x1,ii) = $G(cover(x1,ii),0)+1
			}
			continue
		}
		if (x1 = x2),(y1>y2) {
			for ii = y1:-1:y2 {
				set cover(x1,ii) = $G(cover(x1,ii),0)+1
			}
			continue
		}
		if (y1 = y2),(x1<x2) {
			for ii = x1:1:x2 {
				set cover(ii,y1) = $G(cover(ii,y1),0)+1
			}
			continue
		}
		if (y1 = y2),(x1>x2) {
			for ii = x1:-1:x2 {
				set cover(ii,y1) = $G(cover(ii,y1),0)+1
			}
			continue
		}

		if (x1 < x2),(y1 < y2) {
			s dx =1, dy = 1
		}
		if (x1 < x2),(y1 > y2) {
			s dx=1, dy=-1
		}
		if (x1 > x2),(y1 < y2) {
			s dx=-1, dy=1
		}	
		if (x1 > x2),(y1 > y2) {
			s dx=-1, dy=-1
		}
		s yy = y1
		for xx = x1:dx:x2 {
			s cover(xx,yy) = $G(cover(xx,yy),0)+1
			s yy = yy + dy
		}
	}
	s sum=0
	set x=""
	for {
		set x = $O(cover(x)) if x = "" q
		set y = ""
		for {
			set y = $O(cover(x,y)) if y="" q
			if $g(cover(x,y)) > 1 s sum=sum+1 
		}
	}
	quit sum
}

}
