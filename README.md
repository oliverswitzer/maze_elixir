# MazeElixir

A fun CLI-based maze that uses `ratatouille`, a terminal UI library in elixir.

# How to play

```shell
mix run lib/app.ex
```

Add new mazes in `lib/mazes`. They adhere the following pattern:

```
"*" - wall
" " - moveable space
"s" - starting position
"E" - ending position
```
