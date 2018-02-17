# Elmish Wasm Experiment


# What is this all about?

Web assembly is promising new web technology. Elm is a programming language. Lots of people in the Elm community expect Elm to one day compile to web assembly. This repo is an experiment to see what potential there is for Elm to compile to web assembly.

# How can we make Elm compile to Web Assembly?

I dont know. Thats a really big task. Lets start small.

A lot of people talk about Web Assembly as if its C++ that runs in the browser. Thats not the case. Web Assembly (or "wasm") is human-unreadable bytecode. There is a human-readable version of wasm, called wat. It looks like this..

```
;; A function that adds two numbers
(module
  (func $addTwo (param i32 i32) (result i32)
    get_local 0                     
    get_local 1          
    i32.add
  )       
  (export "addTwo" (func $addTwo))
)
```

Reading that code line by line, it goes something like this..

```
Theres a function called addTwo it takes two int parameters and returns and int. 
First it gets the first parameter,
then it gets the second parameter,
and then it adds the parameters. 
Export addTwo into JavaScript world and name it "addTwo".
```

So to start small, lets make something that merely looks like Elm- we will call it "Elmish"- and compile it to wat. I imagine an Elmish program that compiles to the wat code above looking like this:

```elm
module Main exposing (addTwo)


addTwo : Int -> Int -> Int
addTwo a b =
    a + b

```

Making a compiler that compiles Elmish to wat is what I am trying to do.


## Update : 20180217

Much of what this repo did was reading Elm files with Haskell and Regex, and parsing out the syntax. Thats already what the Elm compiler does, so perhaps its not that valuable of work. Moving forward, one could just hack the Elm compiler to compile to a different target. But rather than that, maybe a different direction entirely is called for: See here: https://gist.github.com/Chadtech/c966d30613c588ef2dc45026a1e29731



