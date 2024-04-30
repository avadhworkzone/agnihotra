import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreenController extends GetxController{

  TextEditingController fullNameController = TextEditingController();
  TextEditingController yourMessageController = TextEditingController();

  makingPhoneCall() async {
    var url = Uri.parse("tel:9913165164");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  sendingMails() async {
    var url = Uri.parse("mailto:zunoon365@gmail.com");
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
