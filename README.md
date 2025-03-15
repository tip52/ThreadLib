# ThreadLib

I made this library because I was sick of having to make bootleg solutions.  
I also made this library because executors refused to properly implement it.

## Functions

### `getscriptfromthread(thread): script`
**How it works:** Gets the script from `gettenv(thread).script`.

### `getallthreads() / getthreads(): table`
**How it works:** Returns all threads found in `getreg`.

### `getscriptthreads(script): table`
**How it works:** Checks all threads from `getthreads` using `getscriptfromthread` for the script.

### `getfunctionthreads(func): table`
**How it works:** Gets the func's script via `getfenv(func).script` and calls `getscriptthreads(script)`.

### `getthreadfunctions(thread): table`
**How it works:** Uses `getgc` to get all functions related to the thread's script.

### `gettenv(thread): table`
**How it works:** Returns the environment of a given thread, containing `_G`, `shared`, and `script`. If `getgenv().overwrite_gettenv` is `true`, it will return a manually constructed environment.

# Usage

 `loadstring(game:HttpGet([[https://raw.githubusercontent.com/tip52/ThreadLib/refs/heads/main/main.lua]]))()`

