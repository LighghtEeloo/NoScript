# NoScript Project
The *NoScript* Proj, also pronunced *KnowScript* Proj, aims at bringing a clearer and cleaner script creation experience in VG100.

*(script: some narrative, instructions or lines in your game.)*

This is a small and simple helper to which can separate your **embedded script lines** from your **Elm code**, which:
1. makes your code's intention clear (not some random scripts embedded all over).
2. makes your scripts clearer to a TC reader - without touching your code.

## Repo Layout
```
├── README.md
├── TestGround
│   └── src
└── WhatYouNeed
    ├── NoScript.py
    ├── Script.elm
    └── scripts.md
```
Everything you need to use this tool is in `WhatYouNeed` directory, and `TestGround` holds a demo, showing a basic usecase.



## Idea

The logic is simple: you first write your scripts and lines in a human-friendly format, and then use this tool to translate it into proper `Elm` code, which could be put to your src file. The process can be illustrated as:

`Embedded Script Representation -> Runable Elm Code`

which actually means:

`scripts.md -> [internal representation] -> InevitableVillainy.elm`

## Usage

The project works by running `python3 NoScript.py`; binary versions are on the way. At the same time, a bridging code called `Script.elm` is given.

First, place `script.md` in the same directory with `NoScript.py` and run `python3 NoScript.py` at this directory. An `InevitableVillainy.elm` will be generated.

Next, place `Script.elm` and `InevitableVillainy.elm` in your src folder.

Together, you can use it in your program like:
```elm
-- import the script function which already knows all your scripts
import Script exposing (script) 

gameLogic : Situation -> String
gameLogic situation =
    case situation of
        ReadLine ->
            script "Scene Chase" 1 -- Get the second line in "Scene Chase" section.
        Run ->
            "!!!"
        _ -> 
            "..."
```

A demo is written for you to play: run `cd TestGround && elm reactor`, and open `Main.elm` to see the effect.

## Script Gramma

For specific gramma, see the example `script.md`:


```
@ Scene one
- Hi.
; Some comments
- Hi there. - And you look good today,
; The above are two phases. To use "- " in your text, 
; you may write two lines and concat them with "- ".
- Aloha!
- Be nice.
; and badass (comments are flexible)

Or naughty.
; Multiple lines enabled.
@

; @xxx ... @ (where '@'s always takes a new line) denotes a section.
@ Scene two
- Hey.
- How's it going?
@


```

Please note that **the spaces are necessary**!!! i.e., please write "- " instead of "-" whenever needed.
Also, "@" clauses require an individual line, meaning "- xxx. @" won't work.
And extra spaces and new-line breaks in your scripts are preserved in the generated code.

## Advanced (?)
You can change the input / output source by changing the first few lines in `NoScript.py`:

