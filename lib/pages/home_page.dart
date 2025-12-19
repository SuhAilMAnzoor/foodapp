import 'package:flutter/material.dart';
import 'package:foodapp/model/category_model.dart';
import 'package:foodapp/model/product_model.dart';
import 'package:foodapp/pages/cart_page.dart';
import 'package:foodapp/utils/consts.dart';
import 'package:foodapp/widgets/food_product_items.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex = 0;
  String category = '';
  List<ProductModel> productModel = [];

  @override
  void initState() {
    super.initState();
    if (myCategories.isNotEmpty) {
      category = myCategories[0].name;
      filterProductByCategory(category);
    }
  }

  void filterProductByCategory(String selectedCategory) {
    setState(() {
      category = selectedCategory;
      productModel = myProductModel
          .where(
            (element) =>
                element.category.toLowerCase() ==
                selectedCategory.toLowerCase(),
          )
          .toList();
    });
  }

  String selectedCity = "Badah";

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: korange, size: 20),
                          SizedBox(width: 5),
                          PopupMenuButton<String>(
                            color: Colors.white,
                            offset: const Offset(0, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            onSelected: (value) {
                              setState(() => selectedCity = value);
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: "Badah",
                                child: Text("Badah"),
                              ),
                              PopupMenuItem(
                                value: "Larkana",
                                child: Text("Larkana"),
                              ),
                              PopupMenuItem(
                                value: "Karachi",
                                child: Text("Karachi"),
                              ),
                              PopupMenuItem(
                                value: "Sukkur",
                                child: Text("Sukkur"),
                              ),
                            ],
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                // 👈 OUTER BORDER
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    selectedCity,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.search, color: kblack),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyCartPage()),
                        );
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: kblack,
                            ),
                          ),
                          cartProvider.carts.isNotEmpty
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Color(0xfff95f60),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        cartProvider.carts.length.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Let's find the best food around you",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: -.4,
                color: kblack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Find by Category",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kblack,
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  myCategories.length,
                  (index) => GestureDetector(
                    onTap: () {
                      filterProductByCategory(myCategories[index].name);
                    },
                    child: Container(
                      height: 110,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: category == myCategories[index].name
                            ? Border.all(width: 2.5, color: korange)
                            : Border.all(color: Colors.white),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: kblack.withOpacity(0.4),
                                      offset: Offset(0, 8),
                                      blurRadius: 12,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                myCategories[index].image,
                                width: 45,
                                height: 45,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            myCategories[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kblack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Results (${productModel.length})",
              style: TextStyle(
                color: kblack.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                letterSpacing: -.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  productModel.length,
                  (index) => Padding(
                    padding: index == 0
                        ? EdgeInsets.only(left: 25, right: 25)
                        : EdgeInsets.only(right: 25),
                    child: FoodProductItems(productModel: productModel[index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
