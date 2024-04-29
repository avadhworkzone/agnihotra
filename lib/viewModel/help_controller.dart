import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreenController extends GetxController{

  makingPhoneCall() async {
    var url = Uri.parse("tel:9913165164");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}