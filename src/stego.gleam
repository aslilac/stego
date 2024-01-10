import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/javascript/promise.{type Promise}
import stego/body

pub type Body =
  body.Body

/// ### `Deno.serve`, but for Gleam!
///
/// `Deno.serve` allows you to create a server using the web standard
/// [`Request`](https://developer.mozilla.org/en-US/docs/Web/API/Request) and
/// [`Response`](https://developer.mozilla.org/en-US/docs/Web/API/Response) types.
/// Stego translates between these types and Gleam's own
/// [`Request`](https://hexdocs.pm/gleam_http/gleam/http/request.html) and
/// [`Response`](https://hexdocs.pm/gleam_http/gleam/http/response.html) types.
/// Your response body can be a `BitArray`, `String`, or `StringBuilder`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleam/http/response
/// import gleam/javascript/promise
/// import stego
///
/// pub fn main() {
///   stego.serve(fn (_request) {
///     response.new(200)
///     |> response.set_header("content-type", "text/html; charset=utf-8")
///     |> response.set_body("<h1>hoi!</h1>")
///     |> promise.resolve()
///   })
/// }
/// ```
///
/// </details>
@external(javascript, "./stego_external.mjs", "denoServe")
pub fn serve(server: fn(Request(Body)) -> Promise(Response(a))) -> Nil
