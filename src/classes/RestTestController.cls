public class RestTestController {
	public class Header {
		public String headerName { get; set; }
		public String headerValue { get; set; }

		public Header(String name, String value) {
			headerName = name;
			headerValue = value;
		}
	}

	public List<Header> oneCookieNoHttpOnly { get; set; }
	public List<Header> oneCookieHttpOnly { get; set; }
	public List<Header> twoCookieNoHttpOnly { get; set; }
	public List<Header> twoCookieHttpOnly { get; set; }

	private List<Header> getResponseHeaders(HttpResponse response) {
		List<String> headerNames = new List<String>();
		List<Header> headers = new List<Header>();
		for (String key : response.getHeaderKeys()) {
			headerNames.add(key);
		}
		headers.sort();
		for (String name : headerNames) {
			if (name == null) {
				continue;
			}
			headers.add(new Header(name, response.getHeader(name)));
		}
		return headers;
	}

	private HttpResponse sendCallout(String url) {
		Http calloutHttp = new Http();
		HttpRequest calloutRequest = new HttpRequest();

		calloutRequest.setEndpoint(url);
		calloutRequest.setMethod('GET');

		return calloutHttp.send(calloutRequest);
	}

	public RestTestController() {
		oneCookieNoHttpOnly = getResponseHeaders(sendCallout('http://cookie-tests.herokuapp.com/one-cookie-no-httponly.php'));
		oneCookieHttpOnly = getResponseHeaders(sendCallout('http://cookie-tests.herokuapp.com/one-cookie-httponly.php'));
		twoCookieNoHttpOnly = getResponseHeaders(sendCallout('http://cookie-tests.herokuapp.com/two-cookies-no-httponly.php'));
		twoCookieHttpOnly = getResponseHeaders(sendCallout('http://cookie-tests.herokuapp.com/two-cookies-httponly.php'));
	}
}