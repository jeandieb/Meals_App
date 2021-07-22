import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import '../widgets/meal_item.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function setFavorite;
  final Function _isMealFavorit;

  MealDetailScreen(this.setFavorite, this._isMealFavorit);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    Meal selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //image
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: Image.network(selectedMeal.imageUrl),
            ),
            //Title-Ingredients
            Card(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              elevation: 15,
              color: Colors.red[100],
              child: Container(
                child: Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            //Ingredients
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                margin: EdgeInsets.only(bottom: 25),
                height: 120,
                width: 250,
                child: ListView.builder(
                    itemCount: selectedMeal.ingredients.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey[200],
                        child: Text(selectedMeal.ingredients[index],
                            style: Theme.of(context).textTheme.headline6),
                      );
                    })),
            //Title-Steps
            Card(
              elevation: 15,
              color: Theme.of(context).accentColor,
              child: Container(
                child: Text(
                  'Steps',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            //Steps
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                height: 200,
                width: 310,
                child: ListView.builder(
                    itemCount: selectedMeal.steps.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Colors.grey[200],
                            child: Row(children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                child: Text(
                                  (index + 1).toString(),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 250,
                                child: Text(selectedMeal.steps[index],
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                            ]),
                          ),
                          Divider()
                        ],
                      );
                    })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          _isMealFavorit(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          setFavorite(mealId);
        },
      ),
    );
  }
}
