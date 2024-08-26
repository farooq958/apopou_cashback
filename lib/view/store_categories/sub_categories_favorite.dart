// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:cashback/controller/add_to_fav_cubit.dart';
import 'package:cashback/controller/all_products_controller.dart';
import 'package:cashback/controller/remove_fav_cubit.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoriesFavorite extends StatefulWidget {
  int id;
  bool guest;
  int index;

  SubCategoriesFavorite({
    required this.id,
    required this.guest,
    required this.index,
  });

  @override
  State<SubCategoriesFavorite> createState() => _SubCategoriesFavoriteState();
}

class _SubCategoriesFavoriteState extends State<SubCategoriesFavorite> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.guest == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        } else {
          if (AllProductsController.listData[widget.index].favoriters == 0) {
            context
                .read<AddToFavCubit>()
                .addToFav(
                    id: widget.id,
                    context: context,
                    index: widget.index,
                    type: 'all')
                .whenComplete(() {
              setState(() {});
            });
          } else {
            context
                .read<RemoveFavCubit>()
                .removeFav(
                    id: widget.id,
                    context: context,
                    index: widget.index,
                    type: "all")
                .whenComplete(() {
              setState(() {});
            });
          }
        }
      },
      child: Container(
        child: Icon(
          Icons.favorite,
          // color: Colors.yellow,
          color: AllProductsController.listData[widget.index].favoriters == 0
              ? Colors.grey
              : Colors.red,
        ),
      ),
    );
  }
}
