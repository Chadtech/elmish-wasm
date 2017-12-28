(module
  (func $addTwo (param i32 i32) (result i32)
    get_local 0
    get_local 1
    i32.add
  )
  (func $addThree (param i32 i32 i32) (result i32)
    get_local 0
    get_local 1
    i32.add
    get_local 2
    i32.add
  )
  (export "addTwo" (func $addTwo))
  (export "addThree" (func $addThree))
)
