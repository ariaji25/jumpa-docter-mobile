import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/persentation/pages/homecare/success.dart';
import '../../../common/extensions/padding_ext.dart';
import '../../widgets/buttons.dart';

class WebViewPage extends StatefulWidget {
  static const routeName = "/WebViewPage";

  const WebViewPage({Key? key}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    return Scaffold(
      floatingActionButton: args[1] == "801"
          ? Padding(
              padding: paddingOnly(
                left: SizeConstants.margin,
                right: SizeConstants.margin,
              ),
              child: Buttons(
                title: "Selesai",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PaymentSuccess.routeName,
                  );
                },
              ),
            )
          : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(args[0])),
              onLoadStop: (ctrl, url) {
                setState(() {
                  isLoading = false;
                });
              },
              onUpdateVisitedHistory: (ctr, url, _) {
                if (url.toString().contains("payment-success")) {
                  // Get.to(const PaymentSuccess());
                }
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack()
          ],
        ),
      ),
    );
  }
}
