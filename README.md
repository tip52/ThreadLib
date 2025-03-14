# ThreadLib
I made this library because I was sick of having to make bootleg solutions
I also made this library because executors refused to properly implement it

# Functions
getscriptfromthread(thread): script
How it works: gets the script from gettenv(thread).script

getallthreads() / getthreads(): table
How it works: returns all threads found in getreg

getscriptthreads(script): table 
How it works: checks all threads from getthreads using getscriptfromthread for the script

getfunctionthreads(func): table
How it works: gets the funcs script via getfenv(func).script and calls getscriptthreads(script)
