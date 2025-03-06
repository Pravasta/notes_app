class Endpoint {
  final String baseURL;

  Endpoint({required this.baseURL});

  // Note for example endpoint
  //  Uri getPaperTradeAccountWallet(String accountID) {
  //   return UriHelper.createUrl(
  //     host: _baseURL,
  //     path: "/api/v2/papertrade/account/account",
  //     queryParameters: {
  //       'account_id': accountID,
  //     },
  //   );
  // }

  factory Endpoint.baseURLAdmin() {
    return Endpoint(baseURL: "wa.me");
  }

  factory Endpoint.staging() {
    return Endpoint(baseURL: "tes.staging");
  }
}
