import 'package:cashback/controller/add_to_fav_cubit.dart';
import 'package:cashback/controller/all_products_controller.dart';
import 'package:cashback/controller/remove_fav_cubit.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';

class AllShopsHeart extends StatefulWidget {
  bool guest;
  int index;
  RefreshController controller;
  AllShopsHeart({
    required this.guest,
    required this.index, required this.controller,
  });

  @override
  State<AllShopsHeart> createState() => _AllShopsHeartState();
}

class _AllShopsHeartState extends State<AllShopsHeart> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.guest == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        } else {
          if (AllProductsController.listData[widget.index].favoriters == 0) {
           await context
                .read<AddToFavCubit>()
                .addToFav(
                    id: AllProductsController.listData[widget.index].identifier,
                    context: context,
                    index: widget.index,
                    type: 'all')
                .whenComplete(() {

              setState(() {});
            });
            widget.controller.requestRefresh(needMove: false);
          } else {
            context
                .read<RemoveFavCubit>()
                .removeFav(
                    id: AllProductsController.listData[widget.index].identifier,
                    context: context,
                    index: widget.index,
                    type: "all")
                .whenComplete(() {
             // widget.controller.requestRefresh();
              setState(() {});
            });
            widget.controller.requestRefresh(needMove: false);
            // AllProductsController.page=1;
            // AllProductsController.listData.clear();
            // context.read<AllShopsCubit>().allShops(reload:true);
          }
        }
      },
      child: Container(
        child: Icon(
          Icons.favorite,
          color: AllProductsController.listData[widget.index].favoriters == 0
              ? Colors.grey
              : Colors.red,
        ),
      ),
    );
  }
}
