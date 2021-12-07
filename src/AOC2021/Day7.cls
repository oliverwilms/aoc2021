Class AOC2021.Day7 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d7.txt";

// w ##class(AOC2021.Day7).Run1()

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		//s line="16,1,2,0,4,2,7,1,2,14"
		set inputlen=$L(line,",")
		set minfuel = inputlen_"000"
		for ii=1:1:$L(line,",") set h(ii)=$P(line,",",ii)
		for target = 0:1:999 {
			set fuel=0
			for ii=1:1:$L(line,",") {
				i fuel>minfuel quit
				if h(ii)=target continue
				if h(ii)<target set fuel=fuel+target-h(ii) continue
				set fuel=fuel+h(ii)-target
				continue
			}
			set hfuel(target)=fuel
			if fuel<minfuel set minfuel=fuel
		}
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return minfuel
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		//s line="16,1,2,0,4,2,7,1,2,14"
		set inputlen=$L(line,",")
		set minfuel = inputlen_"000000000"
		for ii=1:1:$L(line,",") set h(ii)=$P(line,",",ii)
		for target = 0:1:999 {
			set fuel=0
			for ii=1:1:$L(line,",") {
				i fuel>minfuel quit
				if h(ii)=target continue
				if h(ii)<target set dist=target-h(ii)
				if h(ii)>target set dist=h(ii)-target
				for jj=1:1:dist {
					set fuel=fuel+jj
				}
				
				continue
			}
			set hfuel(target)=fuel
			if fuel<minfuel set minfuel=fuel
		}
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return minfuel
}

}
