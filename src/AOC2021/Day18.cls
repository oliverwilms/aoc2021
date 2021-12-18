Class AOC2021.Day18 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d18.txt";

Parameter TestFile = "aoc2021d18test.txt";

// w ##class(AOC2021.Day18).Run1()

ClassMethod parseNumber(ByRef pNumber As %String) As %Status
{
	Set input = $Get(pNumber)
	Kill pNumber
	Set pNumber = input
	Set pp = 0
	Set z = $L(pNumber)
	Set a = 0
	Set cc = "left"
	//For a=1:1:z {
	For {
		Set a = a + 1
		If a > z Quit
		Set e = $E(pNumber,a)
		If e = "[" {
			Set pp=pp+1
			Set pNumber("pp")=pp
			If pp = 2 {
				Set pair = $E(pNumber,a,*)
				Do ..parseNumber(.pair)
				Merge pNumber(1,cc)=pair
				
			}
			Continue
		}
		If e = "]" {
			Set pp=pp-1
			If (pp < 1) Set z = 0
			Continue
		}
		If e = "," {
			Set cc = "right"
			//Set pp = 1
			Continue
		}
		Set x = $E(pNumber,a,*)
		Set y = $P(x,"]",1)
		If pp = 1 {
			If cc = "right" {
				Set right = y
				Set pNumber(pp,"right")=$G(right)
				Continue
			}
			Set left = $P(y,",",1)
			Set right = $P(y,",",2)
			Set pNumber(pp,"left")=$G(left)
			Set pNumber(pp,"right")=$G(right)
		}
		If y = "" Continue
		Set a = a + $L(y) - 1
		//ZWRITE
	}
	Quit ""
}

ClassMethod splitNumber(pInteger As %Integer) As %String
{
	Set pInteger = $Get(pInteger,0)
	Set a = pInteger / 2
	If (a [ ".") {
		Set roundDown = pInteger \ 2
		Set roundUp = roundDown + 1
	} Else {
		Set (roundDown,roundUp) = a
	}
	Quit "["_roundDown_","_roundUp_"]"
}

ClassMethod Addition(
	ByRef pTotal,
	ByRef pLine,
	verbose = 1) As %String
{
	Set pTotal = "["_pTotal_","_pLine_"]"
	If verbose Write pTotal,!
	For {
		Set tSC = ..Reduce(.pTotal)
		If verbose Write pTotal,!
		If (0 = tSC) Quit
	}
	Quit pTotal
}

/*
To explode a pair, the pair's left value is added to the first regular number to the left of the exploding pair (if any), 
and the pair's right value is added to the first regular number to the right of the exploding pair (if any). 
Exploding pairs will always consist of two regular numbers. 
Then, the entire exploding pair is replaced with the regular number 0.
*/
ClassMethod Explode(ByRef pNumber) As %Status
{
	Set tSC = 0
	Set explode = 0
	Set pp = 0
	Set z = $L(pNumber)
	Set a = 0
	
	//For a=1:1:z {
	For {
		Set a = a + 1
		If a > z Quit
		Set e = $E(pNumber,a)
		If e = "[" {
			Set pp=pp+1
			If (pp > 4) {
				Set explode = a  // Explode
			}
			Continue
		}
		If e = "]" {
			Set pp=pp-1
			If (pp < 1) Set z = 0
			Continue
		}
		If e = "," {
			Continue
		}
		Set x = $E(pNumber,a,*)
		Set y = $P(x,"]",1)
		If explode {
			Set explode = a
			Set left = $P(y,",",1)
			Set right = $P(y,",",2)
			If (y '= "") Set a = a + $L(y) - 1
			For {
				Set a = a + 1
				If a > z Quit
				Set e = $E(pNumber,a)
				If "[,]"[e Continue
				Set next = $E(pNumber,a,*)
				Set next = $P(next,"]",1)
				Set next = $P(next,"[",1)
				Set next = $P(next,",",1)
				Set nn = a
				Quit
			}
			Set a = explode
			For {
				Set a = a - 1
				If a < 1 Quit
				Set e = $E(pNumber,a)
				If "[,]"[e Continue
				While ("1234567890"[$E(pNumber,a-1)) { Set a = a - 1 }
				Set prev = $E(pNumber,a,*)
				Set prev = $P(prev,"]",1)
				Set prev = $P(prev,"[",1)
				Set prev = $P(prev,",",1)
				Set pv = a
				Quit
			}
			Quit
		}
	}
	If $Get(nn) {
		Set x = $E(pNumber,nn+$L(next),*)
		Set next = next + right
		Set pNumber = $E(pNumber,1,nn-1)_next_x
	}
	If (explode) {
		Set pNumber = $E(pNumber,1,explode-2)_0_$E(pNumber,(explode+1+$L(y)),*)
		Set tSC = 1
	}
	If $Get(pv) {
		Set x = $E(pNumber,pv+$L(prev),*)
		Set prev = prev + left
		Set pNumber = $E(pNumber,1,pv-1)_prev_x
	}
	Quit tSC
}

ClassMethod Magnitude(ByRef pNumber) As %Integer
{
	Set magnitude = 0
	//Set pp = $Get(pNumber("pp"))
	Set pp = $Get(pNumber(1,"left","pp"))
	If pp {
		Merge pair1 = pNumber(1,"left")
		Set m1 = ..Magnitude(.pair1)
	} Else {
		Set m1 = $Get(pNumber(1,"left"))
	}
	Set pp = $Get(pNumber(1,"right","pp"))
	If pp {
		Merge pair2 = pNumber(1,"right")
		Set m2 = ..Magnitude(.pair2)
	} Else {
		Set m2 = $Get(pNumber(1,"right"))
	}
	Set magnitude = (3 * m1) + (2 * m2)
	Set pNumber("magnitude") = magnitude
	Quit magnitude
}

ClassMethod Reduce(ByRef pNumber) As %String
{
	/*
To reduce a snailfish number, you must repeatedly do the first action in this list that applies to the snailfish number:

If any pair is nested inside four pairs, the leftmost such pair explodes.
If any regular number is 10 or greater, the leftmost such regular number splits.
	*/
	Set tSC = 0
	Set explode = 0
	Set pp = 0
	Set z = $L(pNumber)
	Set a = 0
	
	//For a=1:1:z {
	For {
		If explode {
			Set tSC = ..Explode(.pNumber)
			Quit
		}
		Set a = a + 1
		If a > z Quit
		Set e = $E(pNumber,a)
		If e = "[" {
			Set pp=pp+1
			If (pp > 4) {
				// Explode
				Set explode = a
			}
			Continue
		}
		If e = "]" {
			Set pp=pp-1
			If (pp < 1) Set z = 0
			Continue
		}
		If e = "," {
			Set cc = "right"
			//Set pp = 1
			Continue
		}
	}
	If (0 = tSC) {
		Set tSC = ..Split(.pNumber)
	}
	Quit tSC
	Set cc = $L(pNumber,",")
	For i=1:1:cc {
		Set cc(i)=$P(pNumber,",",i)
		For ii=1:1:$L(cc(i)) {
			if $E(cc(i),ii)="[" set pp=pp+1 Continue
			If (pp > 0) {
				Set x=$E(cc(i),ii)
				If "0123456789"[x {
					If pLeft(pp)="" Set pLeft(pp)=x
					If pLeft(pp)'="",(pRight(pp)="") Set pRight(pp)=x
				}
				Set y=$P(x,"]",1)
				If $L(y,",")=2 {
					Set pLeft=$P(y,",",1)
					Set pRight=$P(y,",",2)
				}
			}
		}
		
	}
	If pp>4 Set action=1
	For {
		If pp>4 Do ..Explode(.pp)
		Set action = 0
		If (action = 0) Quit
	}
	Quit pp
}

ClassMethod Split(ByRef pNumber) As %Status
{
	Set tSC = 0
	Set action = 0
	Set pp = 0
	Set z = $L(pNumber)
	Set a = 0
	
	//For a=1:1:z {
	For {
		Set a = a + 1
		If a > z Quit
		Set e = $E(pNumber,a)
		If e = "[" {
			Set pp=pp+1
			If (pp > 4) {
			}
			Continue
		}
		If e = "]" {
			Set pp=pp-1
			If (pp < 1) Set z = 0
			Continue
		}
		If e = "," {
			Continue
		}
		Set x = $E(pNumber,a,*)
		Set y = $P(x,"]",1)
		Set left = $P(y,",",1)
		If left > 9 Set action = a
		If action Quit
		If (left '= "") Set a = a + $L(left) - 1
	}
	If action {
		Set pair = ..splitNumber(left)
		Set x = $E(pNumber,1,action-1)
		Set y = $E(pNumber,(action+$L(left)),*)
		Set pNumber = x_pair_y
		Set tSC = 1
	}
	Quit tSC
}

ClassMethod Run1(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set y=y+1
		If y=1 Set pNumber=line Continue
		Set m = ..Addition(.pNumber,.line,verbose)
        continue
    }
	Do ..parseNumber(.pNumber)
    Set sum = ..Magnitude(.pNumber)
    return sum
}

ClassMethod Run2(verbose = 0) As %Integer
{
	set stream=..GetInput(..#InputFile)
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set y=y+1
		set arr(y)=line
        continue
    }
    Set max = 0
    For i=1:1:y {
	    For j=1:1:y {
		    If j=i Continue
		    Set pNumber = arr(i)
		    Set line = arr(j)
			Set m = ..Addition(.pNumber,.line,verbose)
			Do ..parseNumber(.pNumber)
			Set sum = ..Magnitude(.pNumber)
			If sum > max Set max = sum
	    }
    }
    return max
}

ClassMethod Test(verbose = 1) As %Integer
{
	set stream=..GetInput(..#TestFile)
	set y=0
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set y=y+1
		If y=1 Set pNumber=line Continue
		Set m = ..Addition(.pNumber,.line,verbose)
        continue
    }
	Do ..parseNumber(.pNumber)
    Set sum = ..Magnitude(.pNumber)
    return sum

	Set p1 = "[9,1]"
	Set p2 = "[1,9]"
	Set pNumber = "["_p1_","_p2_"]"
	Set p2 = "[[3,4],5]"
	Set pNumber = p2
	Set pNumber = "[[1,2],[[3,4],5]]"
	Set pNumber = "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"
	Set pNumber = "[[[[[9,8],1],2],3],4]"
	Set pNumber = "[7,[6,[5,[4,[3,2]]]]]"
	Set pNumber = "[[6,[5,[4,[3,2]]]],1]"
	Set pNumber = "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]"
	Set pNumber = "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"
	Set pNumber = "[[[[4,3],4],4],[7,[[8,4],9]]]"
	Set pLine = "[1,1]"
	Set m = ..Addition(.pNumber,.pLine)
	Quit m
	//Set pNumber = ""
	Set m = ..Explode(.pNumber)
	zw pNumber
	Quit m
	Do ..parseNumber(.pNumber)
	zw pNumber
	Set m = ..Magnitude(.pNumber)
	Quit m
	Set pNumber = "[[[[[9,8],1],2],3],4]"
	Do ..Reduce(.pNumber)
	Write pNumber,!
	Quit 0
}

}
