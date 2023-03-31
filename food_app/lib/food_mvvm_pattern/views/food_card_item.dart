import 'package:flutter/material.dart';

class FoodCardItem extends StatelessWidget {
  late String? name;
  late String? brand;
  late String? imageUrl;
  late double? price;

  FoodCardItem(this.name, this.brand, this.imageUrl, this.price, {Key? key})
      : super(key: key);
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 3,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  brand!,
                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  price.toString(),
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              width: 100,
              height: 100,
              child: Image.asset(
                imageUrl!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
