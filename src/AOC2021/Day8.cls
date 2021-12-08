Class AOC2021.Day8 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d8.txt";

// w ##class(AOC2021.Day8).Run1()

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set one=0
	set two=0
	set svn=0
	set egh=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set before = $P(line," | ",1)
		set after = $P(line," | ",2)
        for dd=1:1:4 {
	        set d(dd) = $P(after," ",dd)
        if $L(d(dd))=2 set one=one+1
        if $L(d(dd))=4 set two=two+1
        if $L(d(dd))=3 set svn=svn+1
        	if $L(d(dd))=7 set egh=egh+1
        }
        continue
    }
    return one+two+svn+egh
}

ClassMethod Run2(test = 1) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set sum=0
	set one=0
	set two=0
	set svn=0
	set egh=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		if test set line = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
		set before = $P(line," | ",1)
        for dd=1:1:10 {
	        set b(dd) = $P(before," ",dd)
        	if $L(b(dd))=2 set two=b(dd)
        	if $L(b(dd))=3 set tre=b(dd) 
        }
        for ii=1:1:3 {
	        set b=$e(tre,ii) if two'[b set segmentA = b quit
        }
        for dd=1:1:10 {
	        set b(dd) = $P(before," ",dd)
	        set minus(dd)=""
        	if $L(b(dd))=6 {
	        	if b(dd) '[ "a" set minus(dd)="a"
	        	if b(dd) '[ "b" set minus(dd)="b"
	        	if b(dd) '[ "c" set minus(dd)="c"
	        	if b(dd) '[ "d" set minus(dd)="d"
	        	if b(dd) '[ "e" set minus(dd)="e"
	        	if b(dd) '[ "f" set minus(dd)="f"
	        	if b(dd) '[ "g" set minus(dd)="g"
	        	if two[minus(dd) set segmentC=minus(dd) quit
        	//if two'[minus(dd) set segmentE = minus(dd) continue
        	} 
        }
        if $E(two,1)=segmentC set segmentF = $E(two,2)
        if $E(two,2)=segmentC set segmentF = $E(two,1)
        

        for dd=1:1:10 {
	        set b(dd) = $P(before," ",dd)
	        set minus(dd)=""
        	if $L(b(dd))=5 {
	        	if b(dd)[segmentC continue
	        	if b(dd) '[ "a" if segmentC '= "a" set minus(dd)="a" set segmentE=minus(dd) quit
	        	if b(dd) '[ "b" if segmentC '= "b" set minus(dd)="b" set segmentE=minus(dd) quit
	        	if b(dd) '[ "c" if segmentC '= "c" set minus(dd)="c" set segmentE=minus(dd) quit
	        	if b(dd) '[ "d" if segmentC '= "d" set minus(dd)="d" set segmentE=minus(dd) quit
	        	if b(dd) '[ "e" if segmentC '= "e" set minus(dd)="e" set segmentE=minus(dd) quit
	        	if b(dd) '[ "f" if segmentC '= "f" set minus(dd)="f" set segmentE=minus(dd) quit
	        	if b(dd) '[ "g" if segmentC '= "g" set minus(dd)="g" set segmentE=minus(dd) quit
        	} 
        	//if two'[minus(dd) set segmentC = minus(dd) quit
        }


        for dd=1:1:10 {
	        set b(dd) = $P(before," ",dd)
	        set minus(dd)=""
        	if $L(b(dd))=6 {
	        	if b(dd) '[ "a" set minus(dd)="a"
	        	if b(dd) '[ "b" set minus(dd)="b"
	        	if b(dd) '[ "c" set minus(dd)="c"
	        	if b(dd) '[ "d" set minus(dd)="d"
	        	if b(dd) '[ "e" set minus(dd)="e"
	        	if b(dd) '[ "f" set minus(dd)="f"
	        	if b(dd) '[ "g" set minus(dd)="g"
        	} 
        	if minus(dd) = segmentC continue
        	if minus(dd) = segmentE continue
        	if minus(dd) = "" continue
        	set segmentD = minus(dd) quit
        }

        for dd=1:1:10 {
	        set b(dd) = $P(before," ",dd)
	        set minus(dd)=""
        	if $L(b(dd))=5 {
	        	if b(dd)'[segmentC continue
	        	if b(dd) '[ "a" if segmentE '= "a" if segmentF '= "a" set minus(dd)="a" set segmentB=minus(dd) quit
	        	if b(dd) '[ "b" if segmentE '= "b" if segmentF '= "b" set minus(dd)="b" set segmentB=minus(dd) quit
	        	if b(dd) '[ "c" if segmentE '= "c" if segmentF '= "c" set minus(dd)="c" set segmentB=minus(dd) quit
	        	if b(dd) '[ "d" if segmentE '= "d" if segmentF '= "d" set minus(dd)="d" set segmentB=minus(dd) quit
	        	if b(dd) '[ "e" if segmentE '= "e" if segmentF '= "e" set minus(dd)="e" set segmentB=minus(dd) quit
	        	if b(dd) '[ "f" if segmentE '= "f" if segmentF '= "f" set minus(dd)="f" set segmentB=minus(dd) quit
	        	if b(dd) '[ "g" if segmentE '= "g" if segmentF '= "g" set minus(dd)="g" set segmentB=minus(dd) quit
        	} 
        	//if two'[minus(dd) set segmentC = minus(dd) quit
        }

		for ii=1:1:7 {
			if ii=1 set b="a"
			if ii=2 set b="b"
			if ii=3 set b="c"
			if ii=4 set b="d"
			if ii=5 set b="e"
			if ii=6 set b="f"
			if ii=7 set b="g"
			if b=segmentA continue
			if b=segmentB continue
			if b=segmentC continue
			if b=segmentD continue
			if b=segmentE continue
			if b=segmentF continue
			set segmentG=b quit
		}
        
		set after = $P(line," | ",2)
		set digits=""
        for dd=1:1:4 {
	        set d(dd) = $P(after," ",dd)
        	if $L(d(dd))=2 set digit=1 set digits=digits_digit continue 
	        if $L(d(dd))=4 set digit=4 set digits=digits_digit continue  
	        if $L(d(dd))=3 set digit=7 set digits=digits_digit continue  
        	if $L(d(dd))=7 set digit=8 set digits=digits_digit continue  
        	if $L(d(dd))=6 if d(dd)'[segmentC set digit=6 set digits=digits_digit continue  
        	if $L(d(dd))=6 if d(dd)'[segmentE set digit=9 set digits=digits_digit continue  
        	if $L(d(dd))=5 if d(dd)'[segmentB if d(dd)'[segmentE set digit=3 set digits=digits_digit continue  
        	if $L(d(dd))=5 if d(dd)'[segmentB if d(dd)'[segmentF set digit=2  set digits=digits_digit continue  
        	if $L(d(dd))=5 if d(dd)'[segmentC set digit=5 set digits=digits_digit continue  
        	set digits=digits_"0"
        }
        set sum=sum+digits
        continue
    }
    return sum
}

}
