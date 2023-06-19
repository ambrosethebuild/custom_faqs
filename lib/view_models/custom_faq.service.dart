import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:custom_faqs/models/faq.dart';
import 'package:flutter/foundation.dart';

class CustomFaqService {
  //
  StreamController? faqsStream = StreamController();
  String? link = "https://fuodz.edentech.online/api/app/faqs";

  CustomFaqService({this.link}) {
    faqsStream?.close();
  }

  Future<List<Faq>> fetchFaqs() async {
    List<Faq> result = [];
    HttpClient httpClient = HttpClient();

    try {
      var url = Uri.parse(link!);
      // Send the GET request
      HttpClientRequest request = await httpClient.getUrl(url);
      HttpClientResponse response = await request.close();
      // Read the response
      String responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.ok) {
        final faqsJsonArray = jsonDecode(responseBody);
        result = (faqsJsonArray as List).map((e) => Faq.fromJson(e)).toList();
      } else {
        throw responseBody;
      }
    } catch (error) {
      if (kDebugMode) {
        print("error ==> $error");
      }
      rethrow;
    }
    return result;
  }
}
