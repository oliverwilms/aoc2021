Class AOC2021.Day3 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d3.txt";

// w ##class(AOC2021.Day3).Run1()

/// Count ONE bits by position into pArray
ClassMethod BitCounter(
	pLine As %String,
	ByRef pArray) As %Status
{
	For ii=1:1:$L(pLine) {
		If $E(pLine,ii) set pArray(ii)=$G(pArray(ii),0)+1  // Increment Bit (1) Counter by position
	}
	Quit $$$OK
}

ClassMethod Binary2Decimal(pBinary As %String) As %Integer
{
    Set pDecimal=0
    Set delta=1
	For ii=$L(pBinary):-1:1 {
		Set bit=$E(pBinary,ii)
		If bit set pDecimal=pDecimal+delta
		Set delta=delta*2
    }
	Quit pDecimal
}

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set count=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set count=count+1
		set tSC = ..BitCounter(line,.count)
        //if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    set gbits=""
    for ii=1:1:$L(line) {
	    set majority = (count(ii) > (count/2))
	    if majority { s bit=1 } else { s bit=0 }
	    set gbits = gbits_bit
    }
    zw gbits
    set gamma=..Binary2Decimal(gbits)
    set ebits=""
    for ii=1:1:$L(line) {
	    set minority = (count(ii) < (count/2))
	    if minority { s bit=1 } else { s bit=0 }
	    set ebits = ebits_bit
    }
    zw ebits
    set ep=..Binary2Decimal(ebits)
    return gamma*ep
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set ox = 0
	set count=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		s count=count+1
		s keep(count)=line
		set tSC = ..BitCounter(line,.count)
        //if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    merge cnt2 = count
    merge keep2 = keep
    zw count
    set keep=0
    set kcnt=count
    for ii=1:1:$L(line) {
	    set keep=0
	    set digits=0
	    for {
		    set keep = $O(keep(keep)) if keep="" quit
		    if $E(keep(keep),ii) set digits=digits+1  // count "1" bits into digits
	    }
	    set target=1
	    if ((kcnt - digits) > digits) set target = 0  // minority
	    for {
		    set keep = $O(keep(keep)) if keep="" quit
		    if $e(keep(keep),ii)'=target kill keep(keep) set kcnt=kcnt-1 if kcnt=1 quit  // compare candidates to target
	    }
	    if kcnt=1 set keep=$O(keep("")) set obits=keep(keep) zw obits quit
    }
	k count
	set count=0
	merge count=cnt2
	merge keep=keep2
    set keep=0
    set kcnt=count
    for ii=1:1:$L(line) {
	    set keep=0
	    set digits=0
	    for {
		    set keep = $O(keep(keep)) if keep="" quit
		    if ($E(keep(keep),ii)=1) s digits=digits+1
	    }
	    s target=0
	    i ((kcnt - digits) > digits) s target = 1  // minority
	    for {
		    set keep = $O(keep(keep)) if keep="" quit
		    if $e(keep(keep),ii)'=target kill keep(keep) set kcnt=kcnt-1 if kcnt=1 quit
	    }
	    if kcnt=1 set keep=$O(keep("")) set cbits=keep(keep) zw cbits quit
		    
    }

    //zw keep
    set ox=..Binary2Decimal(obits)
    set co=..Binary2Decimal(cbits)
    w "ox = ",ox,!
    w "co = ",co,!
    return ox*co
}

}
