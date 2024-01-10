# Stego

`Deno.serve` for Gleam ✨

[Read the documentation](https://hexdocs.pm/stego)

```gleam
import gleam/http/response
import gleam/javascript/promise
import stego

pub fn main() {
  stego.serve(fn (_request) {
    response.new(200)
    |> response.set_header("content-type", "text/html; charset=utf-8")
    |> response.set_body("<h1>hoi!</h1>")
    |> promise.resolve()
  })
}
```
