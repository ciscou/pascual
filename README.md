# pascual
toy compiler for a pascal-like language

## building
just `make` it. You'll need flex, bison, and a C compiler.
Ah, and ruby, because I haven't written a C interpreter (yet?)

## testing
`make test`. If `git diff` is clean you didn't break anything.
You can add new `.pas` files to the `tests/` folder and `make test` will
generate the `.asm` and `.txt` files for you. Don't forget to add
all the test files to git.
