import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_with_bloc/features/cart/cart_bloc.dart';
import 'package:shop_with_bloc/features/home/home_bloc.dart';
import 'package:shop_with_bloc/features/home/models/home_product_data_model.dart';

class CartTileWidget extends StatelessWidget {
  const CartTileWidget({super.key , required this.productDataModel, required this.cartBloc });
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color:Colors.black45),
      ),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productDataModel.imageUrl),
                )
            ),
          ),
          SizedBox(height: 30,),
          Text(productDataModel.name,style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text(productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rs. ' + productDataModel.price.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // cartBloc.add(HomeProductWishlistButtonClickedEvent(
                        //   clickedProduct : productDataModel,
                        // ));

                      },
                      icon: Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartRemoveFromCart(
                          productDataModel: productDataModel,
                        ));

                      },
                      icon: Icon(Icons.shopping_bag)),
                ],
              )
            ],

          )
        ],
      ),
    );
  }
}
