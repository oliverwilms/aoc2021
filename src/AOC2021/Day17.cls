Class AOC2021.Day17 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d17.txt";

// w ##class(AOC2021.Day1).Run1()

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	for vx = 1:1:203 {
		for vy = -111:1:999 {
			Set result = ..Test2(vx,vy)
			if result = 0 continue
			set sum = sum+1
		}
	}
		
    return sum
}

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set vx = 19
	set vy = 1
	Set maxY = ..Test(vx,vy)
    //return maxY
	for vy = vy:1:999 {
		Set test = ..Test(vx,vy)
		if test > maxY Set maxY = test
		//If test < 0 Quit
	}
		
    return maxY
}

ClassMethod Step(
	step,
	ByRef vx,
	ByRef vy,
	ByRef grid) As %Status
{
	Set tSC = 0
	Set maxY = grid("maxY")
	Set x = grid(step,"x")
	Set y = grid(step,"y")
	Set step = step + 1
	Set x = x + vx
	Set y = y + vy
	If (vx > 0) { set vx = vx -1 } else { if (vx < 0) { set vx = vx + 1} }
	Set vy = vy - 1 
	Set grid(step,"x") = x
	Set grid(step,"y") = y
	if (y > maxY) set grid("maxY") = y
	If (x < 156) Quit tSC
	If (x > 202) Quit tSC
	If (y < -110) Quit tSC
	If (y > -69) Quit tSC
	Quit $$$OK
}

ClassMethod Test(
	vx,
	vy) As %Status
{
	Set line = "target area: x=156..202, y=-110..-69"
	Set maxY = 0
	set grid("maxY") = maxY
	Set step = 0
	Set grid(step,"y")=0
	Set grid(step,"x")=0
	//Set vx = 19
	//Set vy = 200
	For step = step:1 {
		Set tSC = ..Step(step,.vx,.vy,.grid)
		w "x = ",grid(step+1,"x"),"  y = ",grid(step+1,"y"),"   vx = ",vx,"   vy = ",vy,!
		If $$$ISOK(tSC) Write "SUCCESS!!",! Quit
		If grid(step+1,"x") > 202 Write "Failed...",! set grid("maxY") = -1 Quit
		If grid(step+1,"y") < -110 Write "Failed...",! set grid("maxY") = -1 Quit
		//Read ans
		//If ($E(ans,1) = " ") Quit
	}
	set maxY = grid("maxY")
    return maxY
}

ClassMethod Test2(
	vx,
	vy) As %Status
{
	Set line = "target area: x=156..202, y=-110..-69"
	Set maxY = 0
	set grid("maxY") = maxY
	Set step = 0
	Set grid(step,"y")=0
	Set grid(step,"x")=0
	set result=0
	//Set vx = 19
	//Set vy = 200
	For step = step:1 {
		Set tSC = ..Step(step,.vx,.vy,.grid)
		w "x = ",grid(step+1,"x"),"  y = ",grid(step+1,"y"),"   vx = ",vx,"   vy = ",vy,!
		If $$$ISOK(tSC) Write "SUCCESS!!",! set result=1 Quit
		If grid(step+1,"x") > 202 Write "Failed...",! set grid("maxY") = -1 Quit
		If grid(step+1,"y") < -110 Write "Failed...",! set grid("maxY") = -1 Quit
		if vx = 0,(grid(step+1,"x") > 202) Write "Failed...",! set grid("maxY") = -1 Quit
		if vx = 0,(grid(step+1,"x") < 156) Write "Failed...",! set grid("maxY") = -1 Quit
		//Read ans
		//If ($E(ans,1) = " ") Quit
	}
	set maxY = grid("maxY")
    return result
}

}
