import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import '../widgets/meal_item.dart';

import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitles;
  List<Meal> displayedMeals;

  @override
  void initState() {
    // DOES NOT WORK BECAUSE OF MODAL ROUTE.. IT RUN EVEN BEFORE BUILED RUNS SO THERE
    //WILL BE NO CONTEXT AT THE TIME WHEN INITSTATE RUNS  
    // final routesArg =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // categoryTitles = routesArg['title'];
    // final categoryId = routesArg['id'];
    // displayedMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    final routesArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;//we could use init state id we 
                                                                         //do not need ModalRoute
    categoryTitles = routesArg['title'];
    final categoryId = routesArg['id'];
    displayedMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }


  void _removeMeal(String mealId)
  {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitles),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
