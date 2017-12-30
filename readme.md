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


# How to compile Elmish to Wat

I dont know how to compile to wat, Ive never made a compiler. But I imagine it would be a two step process. The first step is reading the Elmish code and storing values like the module name, and the functions in the module. If that works without a problem, the second step is writing that program from memory to wat or wasm.

Heres some pseudo Elm code showing how the program can be stored in memory..

```elm

type alias Module =
    { name : String
    , functions : List Function
    }


type alias Function =
    { name : String
    , typeSignature : List Type
    }


type Type
    = Int_
    | Float_
    | Bool_

```

