Class AOC2021.Day15 Extends AOC2021.Base
{

Parameter InputFile = "aoc2021d15.txt";

Parameter TestFile = "aoc2021d15test.txt";

// w ##class(AOC2021.Day15).Run1()

ClassMethod Move(
	ByRef my,
	ByRef mx,
	dir)
{
	if dir=1 set my=my+1
	if dir=2 set mx=mx+1
	Quit
}

ClassMethod Path(
	ByRef path,
	y,
	z)
{
	set path=2
	Set path(1)=1
	Set path(2)=2
	for ii=1:1:(y+z) {
		set qq = path
		set zz=path
		for pp=1:1:zz {
			set path(pp)=path(pp)_1
			set qq = qq+1
			set path(qq)=path(pp)_2
		}
		set path = qq
	}
	Quit
}

ClassMethod Run1(verbose = 0) As %Integer
{
	//set stream=..GetInput(..#TestFile)

	set stream=..GetInput(..#InputFile)
	set debug = 1
	set result=-1
	set y=0
	set previous=-1
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set z = $L(line)
		set y = y + 1
		for x=1:1:z {
			set grid(y,x) = $E(line,x)
		}
		set previous=line
        if verbose write "line="_line," ","sum="_sum,!
        continue
    }
    //do ..Path(.path,y,z)
    //zw path
    set mx=1
    Set my=1
    set risk = 0
    set all=0
    set step = 0
    kill path
    set path=""
    for {
	    set step = step + 1
	    kill ^DebugPath
	    merge ^DebugPath=path
	    set anyChange = 0
	    if all = 0 {
		 	//set path(1,"grid",1,1)=-1
		 	//set path(2,"grid",1,1)=-1
		    set dir = 1
		    set my=2
		    set all=1
		    set delta=grid(my,mx)
		    //set path(1,step,"y")=my
		    //set path(1,step,"x")=mx
		 	set path(1,"risk")=delta
		 	set path(1,"grid",my,mx)=step
		 	set path(1,"mx")=mx
			set path(1,"my")=my
		 	;
		    set dir = 2
		    set my=1
		    set mx=2
		    set all=2
		    set delta=grid(my,mx)
		    //set path(2,step,"y")=my
		    //set path(2,step,"x")=mx
		 	set path(2,"risk")=delta
		 	set path(2,"grid",my,mx)=step
		 	set path(2,"mx")=mx
		 	set path(2,"my")=my
		 	continue
	    }
	    set path = ""
	    set pz=$O(path(path),-1)
	    for {
		    set path = $O(path(path))
		    if path="" quit
		    if (path>pz) quit
		    set done=$G(path(path,"done"))
		    if done continue
			set my = path(path,"my")
			set mx = path(path,"mx")
			kill pmerge
			merge pmerge=path(path)
		    set pp=path
		    for dir=1:1:4 {
			    set py = my
			    set px = mx
			    if dir=1 set py=py+1
			    if dir=2 set px=px+1
			    if dir=3 set py=py-1
			    if dir=4 set px=px-1
			    if py>y kill path(pp) set pp=all+1 continue
			    if px>z kill path(pp) set pp=all+1 continue
			    if py<1 kill path(pp) set pp=all+1 continue
			    if px<1 kill path(pp) set pp=all+1 continue
			    if (px=1),(py=1) kill path(pp) set pp=all+1 continue
			    set previous=$G(path(pp,"grid",py,px))
			    if previous kill path(pp) set pp=all+1 continue
			    
		 		set gridrisk = $Get(gridrisk(py,px),-1)
				if gridrisk > 0 {
				    set delta=grid(py,px)
			    //set path(pp,step,"y")=py
		    	//set path(pp,step,"x")=px
		    		if (pp > all) {
			 			set prisk = pmerge("risk")
		    		} else {
			    		set prisk = path(pp,"risk")
		    		}
			 		set prisk = prisk+delta
					if prisk > gridrisk {
						kill path(pp) set pp=all+1 continue
					}
				}
				//set gridrisk(py,px)=prisk
			    
			    
			    
			    	    set anyChange = 1

			    if pp > all {
				    set all = pp
				    merge path(pp)=pmerge
			    }
			    set delta=grid(py,px)
			    //set path(pp,step,"y")=py
		    	//set path(pp,step,"x")=px
		 		set prisk = path(pp,"risk")+delta


		 		set gridrisk = $Get(gridrisk(py,px),-1)
				if gridrisk > 0 {
					if prisk > gridrisk {
						kill path(pp) set pp=all+1 continue
					}
				}
				set gridrisk(py,px)=prisk
		 		
		 		set path(pp,"risk")=prisk
			 	set path(pp,"grid",py,px)=step
		 		set path(pp,"mx")=px
		 		set path(pp,"my")=py
		 		if (py=y),(px=z) {
			 		set prisk = path(pp,"risk")
			 		set path(pp,"done")=prisk
			 		if (result = -1) set result = prisk
			 		if (prisk < result) set result = prisk
		 		}
		 		if (prisk>result),(result>0) kill path(pp)
		 		set pp = all + 1
			    continue
	    	}
	    }  
	    if anyChange = 0 quit  
    }
    return result
    /*
    for i=2:1:y set dir=dir_1
    for i=2:1:z set dir=dir_2
    For ii=1:1 {
	    Set dd=$E(dir,ii) if dd="" quit
	    do ..Move(.my,.mx,dd)
	    set risk=risk+grid(my,mx)
	    if (my'=y) continue
	    if (mx'=z) continue
	    quit
    }
    */
    return risk
}

ClassMethod Run2(verbose = 0) As %Integer
{
	//set stream=..GetInput(..#TestFile)

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
