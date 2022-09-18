import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category(
      {required this.categoryName,
      required this.networkImage,
      required this.onPress,
      Key? key})
      : super(key: key);
  final String networkImage;
  final String categoryName;
  final Function() onPress;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 6, 34, 56),
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Material(
                  child: InkWell(
                    onTap: widget.onPress,
                    child: Ink(
                      child: Image.network(widget.networkImage),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
