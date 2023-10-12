import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_bloc/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:shop_with_bloc/features/wishlist/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
        backgroundColor: Colors.redAccent,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: (context, state) {
          if(state is WishlistRemovedState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed from wishlist")));
          }
        },
        listenWhen: (previous,current)=>current is WishlistActionState,
        buildWhen:(previous,current)=>current is !WishlistActionState ,
        builder: (context, state) {
          switch(state.runtimeType){
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                        wishlistBloc: wishlistBloc,
                        productDataModel: successState.wishlistItems[index]);
                  });
          }
          return Container();
        },
      ),
    );
  }
}
