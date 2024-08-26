import 'dart:developer';
import 'package:cashback/controller/VivaWallet/loadingweb_cubit.dart';
import 'package:cashback/controller/VivaWallet/services/wallet_services.dart';
import 'package:cashback/controller/VivaWallet/wallet_url_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumUser/premium_user_cubit.dart';
import 'package:cashback/controller/services/dialog_show_cubit.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/web_view/Controller/web_view_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:string_validator/string_validator.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class InAppWebView extends StatelessWidget {
  final String url;
  final bool? fromPayment;
   InAppWebView({super.key, required this.url, this.fromPayment});

 // int loadingPercentage =0;
  @override
  Widget build(BuildContext context) {
    
print('rebuilded');
    //var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [

            Container(
              margin: EdgeInsets.only(top: 1.sh * 0.06),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: BlocListener<PremiumUserCubit, PremiumUserState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is PremiumUserSuccess) {
    //  print("tesss" + walletUrlController.data);

      if(fromPayment==true) {
        if (state.premiumData.isActive ==0 || state.premiumData.isActive ==2) {


        }
        else {
          context.read<DialogShowCubit>().showHideDialog(true);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    }
  },
  child: WebViewPlus(
    backgroundColor: Colors.white,
// onProgress: (p)
//     {
//       WebViewNotifier.loading.value=true;
//     },

// onProgress: (p)
//     {
//       setState(() {
//         loadingPercentage = p;
//       });
//
//     },
//
    onPageStarted: (p){

    },
                onPageFinished: (url) async {


                //  var currentUrl = await controller.webViewController.currentUrl();
                  log("url2 ${url}");
                  //context.read<WalletUrlCubit>().getWalletUrl();
                  context.read<PremiumUserCubit>().getPremiumUserData();
                //  context.read<LoadingWebCubit>().loadingWeb(false);
                 WebViewNotifier.loading.value=false;
              ///failed response
                  ///    //https://demo.vivapayments.com/web/checkout/result?s=3774000300076350&lang=el-GR&eventId=2062
/// success reponse
                  /// https://demo.vivapayments.com/web/checkout/result?t=109402a8-7a4b-46c5-b8c0-a9293f9d275c&s=3774000300076350&lang=el-GR&eventId=0&eci=1

                  ///token from url
//             var data=  getSendTokenFromUrl(url);
//             print("check");
// print(data);
// if(data == false)
//   {}
// else if (data == "test")
//   {
//
// print("no");
//   }
// else
//   {
//     print("data sending.");
//    // await WalletServices().sendTransactionId(data.toString());
//   }


                },
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) async {
                  log("testing url $url");
                  controller.loadUrl(url);
                  var currentUrl = await controller.webViewController.currentUrl();
                  log("current url ${currentUrl}");
                },
              ),
),
            ),
///with bloc
            // BlocConsumer<LoadingWebCubit, bool>(
            //   listener: (context, state) {
            //     // TODO: implement listener
            //   },
            //   builder: (context,  isLoading ) {
            //
            //    // print("loading test ");
            //     //print(isLoading);
            //     return  isLoading ?Center( child: CircularProgressIndicator(color: AppColor.primaryColor,),): Stack();
            //   },
            // ),

            // if (loadingPercentage < 100)
            //   LinearProgressIndicator(
            //     color: AppColor.primaryColor,
            //     value: loadingPercentage / 100.0,
            //   ),
            ///with value notifier
            ///
            ValueListenableBuilder(valueListenable:  WebViewNotifier.loading, builder: (context,bool isLoading,Widget? child){

              return  isLoading ?Center( child: CircularProgressIndicator(color: AppColor.primaryColor,),): Stack();


            }),
            Positioned(
              top: 15.sp,
              left: 5.sp,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30.r,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

        // SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const SizedBox(height: 10),
        //       GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 6),
        //           child: Icon(
        //             Icons.arrow_back,
        //             size: 32.r,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(height: 10),
        //       Container(
        //         width: MediaQuery.of(context).size.width,
        //         height: MediaQuery.of(context).size.height,
        //         child: WebViewPlus(
        //             javascriptMode: JavascriptMode.unrestricted,
        //             onWebViewCreated: (controller) {
        //               log("testing url ${url}");
        //               controller.loadUrl(url);
        //             }),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

   getSendTokenFromUrl(String url) {

    Uri uri = Uri.parse(url);
    String? t = uri.queryParameters['t']??"test";
    String? s = uri.queryParameters['s']??"test";
if(t=="test" && s=="test")
  {
    return false;
  }
else
    print('t: $t');///token
    print('s: $s');///matam pata nista
    //String res= t=="test"?"s="+s: "t="+t+"&s="+s ;
    //String res= t ;
return t.trim();
  }
}
