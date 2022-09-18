import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/api/custom_laptop_api.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/widgets/category.dart';
import 'laptop_screen.dart';

class LaptopsScreen extends StatefulWidget {
  const LaptopsScreen({Key? key}) : super(key: key);

  @override
  State<LaptopsScreen> createState() => _LaptopsScreenState();
}

class _LaptopsScreenState extends State<LaptopsScreen> {
  List<LaptopApiModel> laptopModels = [];
  @override
  void initState() {
    CustomLaptopApi().laptops.forEach((key, value) {
      LaptopApiModel laptopApiModel = LaptopApiModel.fromDocument(value);
      laptopModels.add(laptopApiModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 70, 119),
      body: ListView.builder(
        itemCount: laptopModels.length,
        itemBuilder: (context, index) {
          return Category(
            categoryName: laptopModels[index].id,
            networkImage: laptopModels[index].images!.first,
            onPress: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaptopScreen(
                    model: laptopModels[index],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
