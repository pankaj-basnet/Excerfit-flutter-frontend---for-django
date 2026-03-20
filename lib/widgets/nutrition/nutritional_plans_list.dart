import 'package:flutter/material.dart';

class NutritionalPlansList extends StatelessWidget {
  const NutritionalPlansList({super.key});

  @override
  Widget build(BuildContext context) {
    Future<int> nutritionalProviderGIVESitems() {
      return Future.value(555);
    }

    List<Map<String, String>> nutritionListsTEMP = [
      {"tile": "list 1", "subtitle": "list 1 subti", "icon": "play"},
      {"tile": "list 2", "subtitle": "list 2 subti", "icon": "play"},
      {"tile": "list 3", "subtitle": "list 3 subti", "icon": "play"},
    ];

    return RefreshIndicator(
      onRefresh: () => nutritionalProviderGIVESitems(),
      child: ListView.builder(
        itemCount: nutritionListsTEMP.length,
        itemBuilder: (context, index) => Container(
          color: Colors.amber,
          child:
              // Text(nutritionListsTEMP[index].entries.first.value, style: TextStyle(fontSize: 20),),
              // Text(
              //   nutritionListsTEMP[index]['tile']!,
              //   style: TextStyle(fontSize: 20),
              // ),
              ListTile(
                title: Text(nutritionListsTEMP[index]['tile'] ?? "No tile"),
                subtitle: Text(nutritionListsTEMP[index]['subtitle'] ?? "no tile"),
                trailing: Icon(Icons.nutritionListsTEMP[index]['icon'] ?? "no tile"),
              ),

          ///OUTPUT
          /// list 1
          // list 2
          // list 3
        ),
      ),
    );
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\widgets\nutrition\nutritional_plans_list.dart

