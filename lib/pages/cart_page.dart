import 'package:animate_do/animate_do.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/utils/consts.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
import '../provider/cart_provider.dart';
import '../widgets/cart_item.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<CartModel> cartItems = cartProvider.carts.reversed.toList();
    return Scaffold(
      backgroundColor: kbgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back, color: kblack),
                      ),
                    ),
                  ),
                  Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kblack,
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(
                      cartItems.length,
                      (index) => Container(
                        height: 145,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          top: index == 0 ? 30 : 0,
                          right: 12,
                          left: 12,
                          bottom: 20,
                        ),
                        child: FadeInUp(
                          delay: Duration(milliseconds: (index) * 200),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [CartItems(cart: cartItems[index])],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Delivery",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kblack,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DottedLine(
                          dashLength: 10,
                          dashColor: kblack.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "\$5.99",
                        style: TextStyle(
                          color: korange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Total Order",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DottedLine(
                          dashLength: 10,
                          dashColor: kblack.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "\$${cartProvider.totalCart().toStringAsFixed(2)}",
                        style: TextStyle(
                          color: korange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: kblack,
                    height: 75,
                    minWidth: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      "Pay \$${(cartProvider.totalCart() + 5.99).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
