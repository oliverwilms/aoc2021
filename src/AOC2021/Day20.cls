Class AOC2021.Day20 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d20.txt";

Parameter TestFile = "aoc2021d20test.txt";

// w ##class(AOC2021.Day20).Run1()

ClassMethod DisplayGrid(ByRef input) As %Integer
{
	Set minY = $Order(input(""),1)
	Set maxY = $Order(input(""),-1)
	Set minX = $Order(input(minY,""),1)
	Set maxX = $Order(input(minY,""),-1)
	Set count=0
	For y=minY:1:maxY {
		For x=minX:1:maxX {
			Write input(y,x)
		}
		Write !
	}
	Quit 1
}

ClassMethod Enhance(
	ByRef input,
	ByRef output,
	ByRef count,
	enhancer As %String) As %Integer
{
	Set minY = $Order(input(""),1)
	Set maxY = $Order(input(""),-1)
	Set minX = $Order(input(minY,""),1)
	Set maxX = $Order(input(minY,""),-1)
	Set count=0
	For y=minY-1:1:maxY+1 {
		For x=minX-1:1:maxX+1 {
			Set (b1,b2,b3,b4,b5,b6,b7,b8,b9) = 0
			If (y>minY) {
				 If (x>minX) Set b1=input(y-1,x-1)
				 If (x>=minX),(x<=maxX) Set b2=input(y-1,x)
				 If (x<maxX) Set b3=input(y-1,x+1)
			}
			If (y>=minY),(y<=maxY) {
				If (x>minX) Set b4=input(y,x-1)
				If (x>=minX),(x<=maxX) Set b5=input(y,x)
				If (x<maxX) Set b6=input(y,x+1)
			}
			If (y<maxY) {
				 If (x>minX) Set b7=input(y+1,x-1)
				 If (x>=minX),(x<=maxX) Set b8=input(y+1,x)
				 If (x<maxX) Set b9=input(y+1,x+1)
			}
			Set bits=b1_b2_b3_b4_b5_b6_b7_b8_b9
			Set bits=$TR(bits,".#","01")
			Set pos = ..BitsToDecimal(bits)
			// enhance string starts with position ZERO
			Set pos = pos + 1
			Set output(y,x)=$E(enhancer,pos)
			If (output(y,x)="#") Set count=count+1
		}
	}
	Write "("_minY_":"_minX_") - ("_maxY_":"_maxX_") --> count = ",count,!
	Quit count
}

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set y=y+1
		If y=1 Set enhance=line Continue
		if line="" Continue
		Set z=$L(line)
		for x=1:1:z { set grid(y-2,x)=$E(line,x) }
        continue
    }
    Set maxX = z
    set maxY = y-2
    //Do ..DisplayGrid(.grid)
    Set count = ..Enhance(.grid,.grid1,.x,enhance)
    write "count = ",count,!
    //Do ..DisplayGrid(.grid1)
    Set count = ..Enhance(.grid1,.grid2,.x,enhance)
    write "count = ",count,!
    //Do ..DisplayGrid(.grid2)
    return count
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set y=y+1
		If y=1 Set pNumber=line Continue
        continue
    }
    return y
}

ClassMethod Test(verbose = 1) As %Integer
{
	set stream=..GetInput(..#TestFile)
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set y=y+1
		If y=1 Set enhance=line Continue
		if line="" Continue
		Set z=$L(line)
		for x=1:1:z { set grid(y-2,x)=$E(line,x) }
        continue
    }
    Set maxX = z
    set maxY = y-2
    Do ..DisplayGrid(.grid)
    Set count = ..Enhance(.grid,.grid1,.x,enhance)
    write "count = ",count,!
    Do ..DisplayGrid(.grid1)
    Set count = ..Enhance(.grid1,.grid2,.x,enhance)
    write "count = ",count,!
    Do ..DisplayGrid(.grid2)
    return count
}

}
