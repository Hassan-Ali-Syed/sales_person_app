import 'dart:developer';
 
import 'package:graphql_flutter/graphql_flutter.dart';
 
class GraphQLConfig {
  final _loggerLink = LoggerLink();
  GraphQLClient clientToQuery(String url, Map<String, String>? headers) =>
      GraphQLClient(
        cache: GraphQLCache(),
        link: _loggerLink.concat(HttpLink(
          url,
          defaultHeaders: headers!,
        )),
        defaultPolicies: DefaultPolicies(
          watchQuery: Policies(fetch: FetchPolicy.networkOnly),
          query: Policies(fetch: FetchPolicy.networkOnly),
          mutate: Policies(fetch: FetchPolicy.networkOnly),
        ),
      );
}
 
class LoggerLink extends Link {
  @override
  Stream<Response> request(
    Request request, [
    NextLink? forward,
  ]) {
    Stream<Response> response = forward!(request).map((Response fetchResult) {
      final ioStreamedResponse =
          fetchResult.context.entry<HttpLinkResponseContext>();
      log("Request: $request");
      log("Response:${ioStreamedResponse?.toString() ?? "null"}");
      return fetchResult;
    }).handleError((error) {
      // throw error;
    });
 
    return response;
  }
 
  LoggerLink();
}