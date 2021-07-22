import 'dart:ui';

import 'package:flutter/material.dart';

import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void setFavorite(String mealId) {
    final int existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),);
      });
    }
  }

  bool _isMealFavorite(String id)
  {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w600,
                ),
              )),
      //home: CategoriesScreen(),
      initialRoute:
          '/', //if you want to set the initial screen to something other than home('/')
      routes: //we can also use nameRoutes instead of regular push
          {
        '/': (ctx) => TabsScreen(_favoritedMeals), //instead of home:
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
            _availableMeals), //it is especially useful for larger apps :lecture 163
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(setFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },

      onGenerateRoute:
          (settings) //used when a go to a route that is not defined in the routes table
          {
        //(executes for any unregistered named route)
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },

      onUnknownRoute:
          (settings) //reached when flutter fails to build a screen (it's like a 404 error in web dev)
          {
        //(executes when onGenerateRoute is not defined or doesn't return a valid navigation action)
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
