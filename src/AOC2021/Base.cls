Class AOC2021.Base
{

Parameter Folder = "C:\Users\VHANTXWilmsO\Downloads\";

ClassMethod GetInput(fn) As %Stream
{
   
    set fn=..#Folder_fn
    set stream = ##Class(%Stream.FileCharacter).%New()
    set sc=stream.LinkToFile(fn)
    return stream
}

}
