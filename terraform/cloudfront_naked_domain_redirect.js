function handler(event) {
    var request = event.request;
    var host = request.headers.host.value;
    var uri = request.uri;

    // Check if the request is for the naked domain (e.g., tapoapartamenty.pl).
    // Note: This JavaScript code runs in CloudFront and cannot directly access Terraform variables.
    // We hardcode the naked domain and www domain here based on the expected values.
    if (host === 'tapoapartamenty.pl') {
        var response = {
            statusCode: 301,
            statusDescription: 'Moved Permanently',
            headers: {
                'location': { value: 'https://www.tapoapartamenty.pl' + uri },
                // Recommended HSTS header for security
                'strict-transport-security': { value: 'max-age=31536000; includeSubdomains; preload' }
            }
        };
        return response;
    }

    // If the host is not the naked domain (e.g., it's www.tapoapartamenty.pl),
    // proceed with the request to serve content.
    return request;
}
