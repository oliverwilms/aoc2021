Class AOC2021.Day2 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d2.txt";

// w ##class(AOC2021.Day2).Run1()

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set h = 0
	set d = 0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set aa = $P(line," ",1)
		set ii = $P(line," ",2)
		if (aa = "forward") {
			set h=h+ii
		}
		if (aa = "up") {
			set d=d-ii
		}
		if (aa = "down") {
			set d=d+ii
		}
        //if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return d*h
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set a = 0
	set h = 0
	set d = 0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set aa = $P(line," ",1)
		set ii = $P(line," ",2)
		if (aa = "forward") {
			set h=h+ii
			set d=d+(a*ii)
		}
		if (aa = "up") {
			set a=a-ii
		}
		if (aa = "down") {
			set a=a+ii
		}
        //if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return d*h
}

}
