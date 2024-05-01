import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreenController extends GetxController{

  TextEditingController fullNameController = TextEditingController();
  TextEditingController yourMessageController = TextEditingController();

  makingPhoneCall() async {
    var url = Uri.parse("tel:9913165164");
    print("url==========================> $url");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  sendingMails() async {
    // final Uri url = Uri(
    //   scheme: 'mailto',
    //   path: 'mailto:zunoon365@gmail.com',
    //
    // );
    var url = Uri.parse("mailto:zunoon365@gmail.com");
    print("url ============= $url");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  sendingWhatsappMsg() async {
    String number = '+919913165164';
    var url = Uri.parse('whatsapp://send?phone=$number');
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }else{
      throw 'Could not launch $url';
    }
  }
}
