import { BitArray, List } from "./gleam.mjs";
import { None, Some } from "../gleam_stdlib/gleam/option.mjs";
import { parse_method, Http } from "../gleam_http/gleam/http.mjs";
import { Request as $Request } from "../gleam_http/gleam/http/request.mjs";

export async function requestBodyAsBitArray(request) {
	return new BitArray(new Uint8Array(await request.arrayBuffer()));
}

export function requestBodyAsJson(request) {
	return request.json();
}

export function requestBodyAsText(request) {
	return request.text();
}

const maybe = (v) => (v ? new Some(v) : new None());

export function translateRequest(request) {
	const url = new URL(request.url);
	const port = parseInt(url.port);

	// prettier-ignore
	return new $Request(
		parse_method(request.method)[0],                // method
		List.fromArray([...request.headers.entries()]), // headers
		request,                                        // body
		new Http(),                                     // scheme
		url.hostname,                                   // host
		maybe(port),                                    // port
		url.pathname,                                   // path
		maybe(url.search.substring(1)),                 // query
	);
}

export function translateResponse(response) {
	const body = response.body instanceof BitArray ? response.body.buffer : response.body;

	return new Response(new Blob([body]), {
		status: response.status,
		headers: Object.fromEntries(response.headers.toArray()),
	});
}

export function denoServe(service) {
	Deno.serve(async (request) => {
		const response = await service(translateRequest(request));
		return translateResponse(response);
	});
}
