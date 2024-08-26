import 'package:cashback/controller/add_to_fav_cubit.dart';
import 'package:cashback/controller/all_feature_shops_cubit.dart';
import 'package:cashback/controller/all_featured_controller.dart';
import 'package:cashback/controller/remove_fav_cubit.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';

class FeaturedHeart extends StatefulWidget {
  bool guest;
  int index;
  RefreshController controller;
  String check;
  FeaturedHeart({required this.guest, required this.index, required this.controller, required this.check});

  @override
  State<FeaturedHeart> createState() => _FeaturedHeartState();
}

class _FeaturedHeartState extends State<FeaturedHeart> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          if (widget.guest == false) {
            if (AllFeatureController.listData[widget.index].favoriters == 0) {
              context
                  .read<AddToFavCubit>()
                  .addToFav(
                      id: AllFeatureController
                          .listData[widget.index].identifier,
                      context: context,
                      index: widget.index,
                      type: "feature")
                  .whenComplete(() {
                setState(() {});
                // AllFeatureController.page=1;
                // AllFeatureController.listData.clear();
                // context.read<AllFeatureShopsCubit>().allFeatureShops(reload:true);
              });
             if(widget.check!="fromout") {widget.controller.requestRefresh(needMove: false);}
            } else {
              context
                  .read<RemoveFavCubit>()
                  .removeFav(
                      id: AllFeatureController
                          .listData[widget.index].identifier,
                      context: context,
                      index: widget.index,
                      type: "feature")
                  .whenComplete(() {
                setState(() {});
              });
              // AllFeatureController.page=1;
              // AllFeatureController.listData.clear();
              // context.read<AllFeatureShopsCubit>().allFeatureShops(reload:true);
              if(widget.check!="fromout") {widget.controller.requestRefresh(needMove: false);}
            }
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          }
        },
        child: Icon(
          Icons.favorite,
          color: AllFeatureController.listData[widget.index].favoriters == 0
              ? Colors.grey
              : Colors.red,
        ),
      ),
    );
  }
}
