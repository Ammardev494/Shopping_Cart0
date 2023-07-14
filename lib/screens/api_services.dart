// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';

List? productlist;

getApiData() async {
  var url = Uri.parse('https://hotel.thewebconcept.com/api/pro_api.php');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var productlist = json.decode(response.body);
    print("Response ${response.statusCode}");
    //  print(productlist);
    print("received");
    return productlist;
  } else {
    print('Failed to fetch data. Error: ${response.statusCode}');
  }
}





