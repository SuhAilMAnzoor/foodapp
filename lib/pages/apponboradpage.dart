import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/onboard_model.dart';
import 'package:foodapp/pages/main_page.dart';

import '../utils/consts.dart';
class AppOnBoardPage extends StatefulWidget {
  const AppOnBoardPage({super.key});

  @override
  State<AppOnBoardPage> createState() => _AppOnBoardPageState();
}

class _AppOnBoardPageState extends State<AppOnBoardPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
              itemCount: onboards.length,
              itemBuilder: (context, index){
            return Stack(
              children: [
                Positioned(
                  top: -70,
                  left: 0,
                  right: 0,
                  child: FadeInDown(
                    delay: Duration(milliseconds: 300),
                    child: Image.asset(onboards[index].image,
                    width: 600,
                    height: 600,
                    fit: BoxFit.contain,),
                  )
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height/1.9,
                    child: FadeInUp(
                      delay: Duration(milliseconds: 300),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(onboards[index].text1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold
                            )),
                            SizedBox(height: 15,),
                            Text(onboards[index].text2,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24
                                ))
                          ],
                        ),
                      ),
                    ),
                )
              ],
            );
          },
          ),
          Positioned(
            bottom: 170,
              child: FadeInUp(
                delay: Duration(milliseconds: 300),
                child: Row(
                  children: [
                    ...List.generate(onboards.length, (index){
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        height: 5, width: 50,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15)
                        ),
                      );
                    })
                  ],
                ),
              ),
          ),
          Positioned(
            bottom: 30,
              child: FadeInUp(
                delay: Duration(milliseconds: 300),
                child: SizedBox(
                  height: 75,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()
                      ));
                    },
                    color: korange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  minWidth: MediaQuery.of(context).size.width-50,
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),),),
                ),
                ),
                ),
              ),

          )

        ],
      ),
    );
  }
}
