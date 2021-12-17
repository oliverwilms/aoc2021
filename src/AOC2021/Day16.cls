Class AOC2021.Day16 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d16.txt";

// w ##class(AOC2021.Day1).Run1()

ClassMethod BitsToDecimal(bits As %String) As %Integer
{
	If $Get(bits) = "" Set bits = "0"
	Set z = $L(bits)
	Set decimal = 0
	Set binary = 1
	For bb = z:-1:1 {
		Set b = $E(bits,bb)
		If (b = "1") {
			Set decimal = decimal + binary
		}
		Set binary = binary + binary
	}
	Quit decimal
}

ClassMethod HexToBits(pHex As %String) As %String
{
	Set bits=""
	If pHex="0" Set bits="0000"
	If pHex="1" Set bits="0001"
	If pHex="2" Set bits="0010"
	If pHex="3" Set bits="0011"
	If pHex="4" Set bits="0100"
	If pHex="5" Set bits="0101"
	If pHex="6" Set bits="0110"
	If pHex="7" Set bits="0111"
	If pHex="8" Set bits="1000"
	If pHex="9" Set bits="1001"
	If pHex="A" Set bits="1010"
	If pHex="B" Set bits="1011"
	If pHex="C" Set bits="1100"
	If pHex="D" Set bits="1101"
	If pHex="E" Set bits="1110"
	If pHex="F" Set bits="1111"
	Quit bits
}

ClassMethod IsZero(pBits As %String) As %Status
{
	Set tSC = 0
	Set z = $L($G(pBits,""))
	If (z = 0) Quit $$$OK
	For {
		Set bit = $E(pBits,z)
		If (bit '= "0") Quit
		Set z = z -1
		If (z < 1) {
			Set tSC = $$$OK
		}
	}
	Quit tSC
}

ClassMethod LineToBits(pLine As %String) As %String
{
	Set binaryPackage=""
	Set packageLen = $L(pLine)
	For ii = 1:1:packageLen {
		Set hex = $E(pLine,ii)
		Set bits = ..HexToBits(hex)
		Set binaryPackage = binaryPackage_bits
	}
	Quit binaryPackage
}

ClassMethod PackageGrow(
	ByRef pPackage,
	pLine As %String,
	ByRef pos,
	pLen As %Integer)
{
	Set verbose = 1
	Set packageLen = $L(pPackage)
	If $Get(pLen) = "" Set pLen = packageLen + 4
	While (packageLen < pLen) {
		Set pos = pos + 1,hex = $E(pLine,pos),bits = ..HexToBits(hex),pPackage = pPackage_bits
		If verbose Write "hex = ",hex,!
		If verbose Write "bits = ",bits,!
		Set packageLen = $L(pPackage)
	}
	If verbose Write "pPackage = ",pPackage,!
	Quit
}

ClassMethod Process(pLine As %String) As %Integer
{
	Set pos = 0
	Set sum = 0
	Set tSC = $$$OK
	Set verbose = 1
	Set z = $L(pLine)
	If verbose Write "$L = ",z,!
	set package = ""
	//Do ..PackageGrow(.package,pLine,.pos,24)
	Set package = ..LineToBits(pLine)
	Set version = $E(package,1,3)
	If verbose Write "version = ",version,!
	Set decVersion = ..BitsToDecimal(version)
	If verbose Write "decVersion = ",decVersion,!
	Set typID = $E(package,4,6)
	If verbose Write "typID = ",typID,!
	Set tLiteral = (typID = "100")  // typID = 4
	If verbose Write "tLiteral = ",tLiteral,!
	Set tOperator = (typID '= "100")  // typID <> 4
	If verbose Write "tOperator = ",tOperator,!
	Set sum = sum + decVersion
	If tOperator {
		Set tI = $E(package,7)
		If verbose Write "Operator I = ",tI,!
		If (tI = 0) {
			// If the length type ID is 0, then the next 15 bits are a number that represents the total length in bits of the sub-packets contained by this packet.
			Set tBits = $E(package,8,22)
			If verbose Write "tBits = ",tBits,!
			Set decBits = ..BitsToDecimal(tBits)
			If verbose Write "decBits = ",decBits,!
			Set pos1 = 23
			Set pos2 = pos1 + decBits - 1
			Set subPackage = $E(package,pos1,pos2)
			Set pos = pos2 + 1
			Set leftover = $E(package,pos,*)
			If verbose Write "leftover = ",leftover,!
		}
		If (tI = 1) {
			// If the length type ID is 1, then the next 11 bits are a number that represents the number of sub-packets immediately contained by this packet.
			Set tSubPackets = $E(package,8,18)
			If verbose Write "tSubPackets = ",tSubPackets,!
		}
	}
	Quit sum
}

ClassMethod ProcessLine(
	pLine As %String,
	verbose = 0) As %Integer
{
	Set pos = 0
	Set sum = 0
	Set tSC = $$$OK
	//Set verbose = 0
	Set z = $L(pLine)
	If verbose Write "$L = ",z,!
	set package = ""
	//Do ..PackageGrow(.package,pLine,.pos,24)
	//Set package = ..LineToBits(pLine)
	Set package = pLine
	Set version = $E(package,1,3)
	If verbose Write "version = ",version,!
	Set decVersion = ..BitsToDecimal(version)
	If verbose Write "decVersion = ",decVersion,!
	Set typID = $E(package,4,6)
	If verbose Write "typID = ",typID,!
	Set tLiteral = (typID = "100")  // typID = 4
	If verbose Write "tLiteral = ",tLiteral,!
	Set tOperator = (typID '= "100")  // typID <> 4
	If verbose Write "tOperator = ",tOperator,!
	Set sum = sum + decVersion
	If tLiteral {
		Set pos = 7
		For {
			Set prefix = $E(package,pos)
			Set bits = $E(package,pos+1,pos+4)
			Set pos = pos + 5
			If (0=prefix) Quit
			Continue
		}
	}
	If tOperator {
		Set tI = $E(package,7)
		If verbose Write "Operator I = ",tI,!
		If (tI = 0) {
			// If the length type ID is 0, then the next 15 bits are a number that represents the total length in bits of the sub-packets contained by this packet.
			Set tBits = $E(package,8,22)
			If verbose Write "tBits = ",tBits,!
			Set decBits = ..BitsToDecimal(tBits)
			If verbose Write "decBits = ",decBits,!
			Set pos1 = 23
			Set pos2 = pos1 + decBits - 1
			Set subPackage = $E(package,pos1,pos2)
			Set x = ..ProcessLine(subPackage,verbose)
			Set sum = sum + x
			Set pos = pos2 + 1
			//Set leftover = $E(package,pos,*)
			//If verbose Write "leftover = ",leftover,!
		}
		If (tI = 1) {
			// If the length type ID is 1, then the next 11 bits are a number that represents the number of sub-packets immediately contained by this packet.
			Set tSubPackets = $E(package,8,18)
			If verbose Write "tSubPackets = ",tSubPackets,!
			Set pos = 19
			For ii=1:1:tSubPackets {
				Set subPackage = $E(package,pos,*)
				set x = ..ProcessSubPackages(subPackage,.pos,verbose)
				set sum = sum + x
			}
		}
	}
	Set leftover = $E(package,pos,*)
	If verbose Write "leftover = ",leftover,!
	Quit sum
}

/// If the length type ID is 1, then the next 11 bits are a number that represents the number of sub-packets immediately contained by this packet.
ClassMethod ProcessSubPackages(
	ByRef package As %String,
	ByRef pos,
	termFlag As %String,
	verbose = 0) As %Integer
{
	Set pos = 0
	Set sum = 0
	Set tSC = $$$OK
	Set continue = 1
	Set z = $L(package)
	If verbose Write "$L = ",z,!
	Do {
		Set package = $E(package,pos,*)
		If verbose Write "package = ",package,!
		Set version = $E(package,1,3)
		If verbose Write "version = ",version,!
		Set decVersion = ..BitsToDecimal(version)
		If verbose Write "decVersion = ",decVersion,!
		Set typID = $E(package,4,6)
		If verbose Write "typID = ",typID,!
		Set tLiteral = (typID = "100")  // typID = 4
		If verbose Write "tLiteral = ",tLiteral,!
		Set tOperator = (typID '= "100")  // typID <> 4
		If verbose Write "tOperator = ",tOperator,!
		Set sum = sum + decVersion
		If tLiteral {
			Set pos = 7
			For {
				Set prefix = $E(package,pos)
				Set bits = $E(package,pos+1,pos+4)
				If verbose Write "bits = ",bits,!
				Set pos = pos + 5
				If (0=prefix) Quit
				Continue
			}
		}
		If tOperator {
			Set tI = $E(package,7)
			If verbose Write "Operator I = ",tI,!
			If (tI = 0) {
				// If the length type ID is 0, then the next 15 bits are a number that represents the total length in bits of the sub-packets contained by this packet.
				Set tBits = $E(package,8,22)
				If verbose Write "tBits = ",tBits,!
				Set decBits = ..BitsToDecimal(tBits)
				If verbose Write "decBits = ",decBits,!
				Set pos1 = 23
				Set pos2 = pos1 + decBits - 1
				Set subPackage = $E(package,pos1,pos2)
				Set termFlag = ""
    			Set x = ..ProcessSubPackages(subPackage,.pos,termFlag,verbose)
				Set sum = sum + x
				Set pos = pos2 + 1
			}
			If (tI = 1) {
				// If the length type ID is 1, then the next 11 bits are a number that represents the number of sub-packets immediately contained by this packet.
				Set packets = $E(package,8,18)
				If verbose Write "packets = ",packets,!
				Set tSubPackets = ..BitsToDecimal(packets)
				Set pos = 19
				Set package = $E(package,pos,*)
   				Set x = ..ProcessSubPackages(.package,.pos,tSubPackets,verbose)
				set sum = sum + x
			}
		}
		If ($Get(termFlag,0) > 0) {
			Set termFlag = termFlag - 1
			If (termFlag < 1) Set continue = 0
		}
		Set leftover = $E(package,pos,*)
		If verbose Write "leftover = ",leftover,!
		Set test = ..IsZero(leftover)
		If $$$ISOK(test) Set continue = 0
	} while continue
	Quit sum
}

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
	Set package = ..LineToBits(line)
	Set termFlag = ""  // process ENTIRE package
    Set sum = ..ProcessSubPackages(package,.pos,termFlag,verbose)
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

ClassMethod Test(verbose = 0) As %Status
{
	Set line = "38006F45291200"
	Set line = "EE00D40C823060"
	Set line = "8A004A801A8002F478"
	Set package = ..LineToBits(line)
	Set termFlag = ""  // process ENTIRE package
    Set sum = ..ProcessSubPackages(package,.pos,termFlag,verbose)
    return sum
}

}
