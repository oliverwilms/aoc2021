Class AOC2021.Day1 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d1.txt";

// w ##class(AOC2021.Day1).Run1()

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		if (previous>0) {
			if (line > previous) set sum=sum+1
		}
		set previous=line
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return sum
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set aaa=-1
	set bbb=-1
	set compare=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		if aaa=-1 { set aaa=line continue }
		if bbb=-1 { set bbb=line continue }
		set ccc=line
		set value=aaa+bbb+ccc
		set aaa=bbb
		set bbb=ccc
		if (compare>0) {
			if (value > compare) set sum=sum+1
		}
        s compare=value
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return sum
}

}
