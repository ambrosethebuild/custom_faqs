import 'dart:async';
import 'dart:convert';

import 'package:custom_faqs/models/faq.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CustomFaqService {
  //
  StreamController? faqsStream = StreamController();
  String? link = "https://fuodz.edentech.online/api/app/faqs";

  CustomFaqService({this.link}) {
    faqsStream?.close();
  }

  Future<List<Faq>> fetchFaqs() async {
    List<Faq> result = [];

    try {
      var url = Uri.parse(link!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final faqsJsonArray = jsonDecode(response.body);
        result = (faqsJsonArray as List).map((e) => Faq.fromJson(e)).toList();
      } else {
        throw response.body;
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
