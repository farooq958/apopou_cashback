import 'dart:developer';
import 'package:cashback/controller/add_to_fav_cubit.dart';
import 'package:cashback/controller/remove_fav_cubit.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/retailers_search_cubit/retailers_search_cubit.dart';

class SearchItemFavorite extends StatefulWidget {
  bool guest;
  int index;
  final void Function() updateFavorite;

  SearchItemFavorite({
    required this.guest,
    required this.index,
    required this.updateFavorite,
  });

  @override
  State<SearchItemFavorite> createState() => _SearchItemFavoriteState();
}

class _SearchItemFavoriteState extends State<SearchItemFavorite> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.guest == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        } else {
          if (RetailerSearchController.data.data[widget.index].favoriters ==
              0) {
            log("CALLED 1");
            context
                .read<AddToFavCubit>()
                .addToFav(
                    id: RetailerSearchController
                        .data.data[widget.index].identifier,
                    context: context,
                    index: widget.index,
                    type: 'all')
                .whenComplete(() {
              setState(() {
                RetailerSearchController.data.data[widget.index].favoriters = 1;
              });
            });
            widget.updateFavorite();
          } else {
            log("CALLED 2");
            context
                .read<RemoveFavCubit>()
                .removeFav(
                    id: RetailerSearchController
                        .data.data[widget.index].identifier,
                    context: context,
                    index: widget.index,
                    type: "all")
                .whenComplete(() {
              setState(() {
                RetailerSearchController.data.data[widget.index].favoriters = 0;
              });
            });
            widget.updateFavorite();
          }
        }
      },
      child: Container(
        child: Icon(
          Icons.favorite,
          color:
              RetailerSearchController.data.data[widget.index].favoriters == 0
                  ? Colors.grey
                  : Colors.red,
        ),
      ),
    );
  }
}
