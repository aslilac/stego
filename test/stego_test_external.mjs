import * as should from "../gleeunit/gleeunit/should.mjs";
import { translateRequest, translateResponse } from "./stego_external.mjs";

export function incoming_request_external() {
	const request = new Request("http://example.com:8080/friend?name=bandit", {
		method: "put",
		headers: { authorization: "wiggle" },
		body: "test request",
	});
	return translateRequest(request);
}

export async function outgoing_response_external(res) {
	const response = translateResponse(res);

	should.equal(response.status, 301);
	should.equal(response.headers.get("powered-by"), "wiggles");
	should.equal(await response.text(), "test response");
}
