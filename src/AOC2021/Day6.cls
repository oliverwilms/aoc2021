Class AOC2021.Day6 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d6.txt";

// w ##class(AOC2021.Day6).Run1()

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
		for day =1:1:80 {
		set cnt=$L(line,",")
		for ii=1:1:cnt {
			set lf=$P(line,",",ii)
			if lf=0 set line=line_",8",lf=7
			set lf=lf-1
			set $P(line,",",ii)=lf
		}
		}
		set sum=$L(line,",")
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    return sum
}

ClassMethod Birth(
	pNumber As %Integer,
	pDays) As %Integer
{
	s inputdays=pDays
	if (pDays<=pNumber) quit 0
	if $g(^birth(pNumber,inputdays)) quit ^birth(pNumber,inputdays)
	//w "Birth ",pDays,!
	s sum = 1
	s lf=pNumber
	//s line=line_",8"
	s pDays=pDays-lf-1
	s lf=8
	while pDays>0 {
		s sum=sum+..Birth(lf,pDays)
		s lf=6
		s pDays=pDays-6
	}
	//w sum,!
	s ^birth(pNumber,inputdays)=sum
	quit sum
}

ClassMethod Offspring(
	pNumber As %Integer,
	pDays) As %Integer
{
	if $G(^offspring(pNumber,pDays)) Quit ^offspring(pNumber,pDays)
	Set sum = 0
	set inumber=pNumber
	For day=1:1:pDays {
		Set pNumber = pNumber - 1
		If (pNumber < 0) {
			Set sum = sum + 1
			Set sum = sum + ..Offspring(8,pDays-day)
			Set pNumber = 6
		}
	}
	s ^offspring(inumber,pDays)=sum
	Quit sum
}

ClassMethod Test(tdays = 80) As %Integer
{
	s line = "3,4,3,1,2"
	s inputlen=$L(line,",")
	write line,!
	//set tdays=80
	s sum=$L(line,",")
		for day =tdays:-1:1 {
			//set cnt=$L(line,",")
			for ii=1:1:inputlen {
				set lf=$P(line,",",ii)
				if lf=0 set lf=7 set sum=sum+ ..Birth(.line,day)
				set lf=lf-1
				set $P(line,",",ii)=lf
			}
			write line,!
		}
		set sum=$L(line,",")
	
	return sum
}

ClassMethod Test2(tdays = 18) As %Integer
{
	k ^birth
	s line = "3,4,3,1,2"
	s inputlen=$L(line,",")
	//write line,!
	//set tdays=80
	s sum=$L(line,",")
		//for day =tdays:-1:1 {
			//set cnt=$L(line,",")
	for ii=1:1:inputlen {
		set lf=$P(line,",",ii)
		set add = ..Offspring(lf,tdays)
		set sum=sum + add
	}
	return sum
	//w "Birth ",pDays,!
		s pDays=tdays-lf
		//i (pDays>0) s sum = sum+1
	//s lf=9
	//s line=line_",8"
	//i pDays<=lf quit sum
	//s pDays=pDays-9
	
			//while pDays>0 {
				s sum=sum+..Birth(.line,pDays)
				s pDays=pDays-7
			//}
	//w sum,!
	//quit sum

				
				//if lf=0 set lf=7 set sum=sum+ ..Birth(.line,day)
				//set lf=lf-1
				//set $P(line,",",ii)=lf
	//		}
			write line,!
		//}
		//set sum=$L(line,",")
	w "sum=",sum,!
	return sum
}

ClassMethod Run2(tdays = 256) As %Integer
{
	//s line = "3,4,3,1,2"
	set stream=..GetInput(..#InputFile)
	set sum=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
	}
	s inputlen=$L(line,",")

	k ^birth
	s inputlen=$L(line,",")
	//write line,!
	//set tdays=80
	s sum=$L(line,",")
		//for day =tdays:-1:1 {
			//set cnt=$L(line,",")
	for ii=1:1:inputlen {
		set lf=$P(line,",",ii)
		set add = ..Offspring(lf,tdays)
		set sum=sum + add
	}
	return sum


	//write line,!
	s cnt=0
	s sum=$L(line,",")
		for day =tdays:-1:1 {
			//set cnt=$L(line,",")
			s cnt=cnt+1
			for ii=1:1:inputlen {
				set lf=$P(line,",",ii)
				if lf=0 set lf=7 set sum=sum+ ..Birth(.line,day)
				set lf=lf-1
				set $P(line,",",ii)=lf
			}
			//write line,!
		set sum=$L(line,",")
			w day,!
			i cnt<81 w sum,!
		}
		//set sum=$L(line,",")
	
	return sum
}

}
