import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_bloc/features/cart/cart_bloc.dart';
import 'cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState(){
    cartBloc.add(CartInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart items"),
        backgroundColor: Colors.redAccent,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,


        listenWhen: (previous,current)=>current is CartActionState,
        listener: (context, state) {

          if (state is CartRemovedState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed from cart")));
          }

        },

        buildWhen: (previous,current)=>current is !CartActionState,
        builder: (context, state) {
          switch(state.runtimeType){
            case CartSuccessState:
            final successState = state as CartSuccessState;
            return  ListView.builder(
          itemCount: successState.cartItems.length,
          itemBuilder: (context, index) {
          return CartTileWidget(
          cartBloc: cartBloc,
          productDataModel: successState.cartItems[index]);
          });

          }
          return Container();
        },
      ),

    );
  }
}
