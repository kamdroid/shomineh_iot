import 'package:flutter/services.dart';
import 'package:shomineh/common/Util.dart';
import 'package:url_launcher/url_launcher.dart';


/// this class is use for calling native methods from android and ios
class NativeMethods {

  /// opens [url] in default browser
  Future<void> callBrowser(String url) async {

    try{
      Uri uri;
      if(url.contains("%")) {
        uri = Uri.parse(Uri.decodeComponent(url));
      } else {
        uri = Uri.parse(url);
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication );
    } on Exception catch(e){
    }

  }


 /// uses this method for opening a chat with written message[text]
  void openWhatsapp(String number, String text){
    callBrowser("https://wa.me/$number?text=$text");
  }

  /// opens default dialer app with [number] ready to dial
  void openDialer(String number) {
    if(isTargetPhone) {
      // _platform.invokeListMethod(PHONE, {"number": "tel:$number"});
      launchUrl(Uri.parse("tel:$number"));
    }
  }


  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

}
