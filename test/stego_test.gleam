import gleeunit
import gleeunit/should
import gleam/bit_array
import gleam/http.{Put}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/javascript/promise.{type Promise}
import gleam/option.{Some}
import stego.{type Body}
import stego/body

pub fn main() {
  gleeunit.main()
}

@external(javascript, "./stego_test_external.mjs", "incoming_request_external")
fn incoming_request_external() -> Request(Body)

pub fn incoming_request_test() {
  let req = incoming_request_external()

  should.equal(req.method, Put)
  should.equal(req.path, "/friend")
  should.equal(req.query, Some("name=bandit"))

  req
  |> request.get_header("authorization")
  |> should.equal(Ok("wiggle"))

  use text <- promise.await(body.text(req.body))

  text
  |> should.equal("test request")

  promise.resolve(Nil)
}

@external(javascript, "./stego_test_external.mjs", "outgoing_response_external")
fn outgoing_response_external(res: Response(a)) -> Promise(Nil)

pub fn outgoing_response_test() {
  let res =
    response.new(301)
    |> response.set_header("powered-by", "wiggles")
    |> response.set_body(bit_array.from_string("test response"))

  outgoing_response_external(res)
}
