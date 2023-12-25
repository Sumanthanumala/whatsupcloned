import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class Dynamiclinkprovider {
  Future<void> createdynamiclink() async {
    final link = Uri.parse(
        "https://www.yourwebsite.page/statuspage"); //final brower to be opened in webbrowser
    const uriprefix =
        "https://whatsappcloned.page.link"; //link that is displayed to users
    final andriodparameters = AndroidParameters(
        packageName:
            "com.example.whatsupclone", //when app is not installed it redirects the user to the playstor and tells to install it if app is live
        fallbackUrl: Uri.parse(
            "https://chat.openai.com/")); //brower to be opened when app is not installed in android phone and not live in playstore
    final parameters = DynamicLinkParameters(
        link: link, uriPrefix: uriprefix, androidParameters: andriodparameters);
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        parameters,
        shortLinkType: ShortDynamicLinkType.unguessable);
    print(dynamicLink.shortUrl);
  }
}
