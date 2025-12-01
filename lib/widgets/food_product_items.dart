import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/provider/cart_provider.dart';
import 'package:foodapp/utils/consts.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';

class FoodProductItems extends StatelessWidget {
  final ProductModel productModel;

  const FoodProductItems({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          //Main Container
          height: 190,
          width: size.width / 2.4,
          decoration: BoxDecoration(
            color: Colors.white, // white Container behind he items
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: 222,
          width: size.width / 2.4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: 10 * pi / 200,
                  child: SizedBox(
                    height: 100, //one60
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 10,
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(productModel.image, height: 150),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  productModel.name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kblack,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star_rate_rounded, color: kyellow, size: 22),
                        SizedBox(width: 5),
                        Text(
                          productModel.rate.toString(),
                          style: TextStyle(color: kblack.withOpacity(.5)),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: kpink, size: 20),
                        Text(
                          "${productModel.distance.toString()}m",
                          style: TextStyle(
                            color: kblack.withOpacity(.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${productModel.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kblack,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              cartProvider.addCart(productModel);
            },
            child: Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: kblack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Icon(CupertinoIcons.shopping_cart, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
