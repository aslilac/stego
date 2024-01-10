import gleam/dynamic.{type Dynamic}
import gleam/javascript/promise.{type Promise}

/// Represents a request body received from a client. This value is consumed when read,
/// meaning it can only be read once.
/// https://developer.mozilla.org/en-US/docs/Web/API/Request#instance_methods
pub type Body

/// Parse the request body as binary, and receive it as a `BitArray`
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleam/javascript/promise
/// import stego/body
///
/// use bytes <- promise.await(
///   request.body
///   |> body.bit_array()
/// )
/// ```
///
/// </details>
///
@external(javascript, "../stego_external.mjs", "requestBodyAsBitArray")
pub fn bit_array(body: Body) -> Promise(BitArray)

/// Parse the request body as JSON, and receive it as a `Dynamic`
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleam/dynamic
/// import gleam/javascript/promise
/// import gleam/json
/// import stego/body
///
/// use puppy_json <- promise.await(
///   request.body
///   |> body.json()
/// )
///
/// dynamic.decode3(
///   Puppy,
///   dynamic.field("name", of: dynamic.string),
///   dynamic.field("good", of: dynamic.bool),
///   dynamic.field("soft", of: dynamic.bool),
/// )
/// |> json.decode(from: puppy_json)
/// ```
///
/// </details>
///
@external(javascript, "../stego_external.mjs", "requestBodyAsJson")
pub fn json(body: Body) -> Promise(Dynamic)

/// Parse the request body as text, and receive it as a `String`
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleam/javascript/promise
/// import stego/body
///
/// use text <- promise.await(
///   request.body
///   |> body.text()
/// )
/// ```
///
/// </details>
///
@external(javascript, "../stego_external.mjs", "requestBodyAsText")
pub fn text(body: Body) -> Promise(String)
