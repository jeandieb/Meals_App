import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';

import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
            headline6: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.w600,),)
      ),
      //home: CategoriesScreen(),
      initialRoute: '/', //if you want to set the initial screen to something other than home('/')
      routes://we can also use nameRoutes instead of regular push 
      { 
        '/': (ctx) => TabsScreen(), //instead of home: 
        CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(),  //it is especially useful for larger apps :lecture 163
        MealDetailScreen.routeName : (ctx) => MealDetailScreen(),
        FiltersScreen.routeName : (ctx) => FiltersScreen(),
      },
      
      onGenerateRoute: (settings) //used when a go to a route that is not defined in the routes table
      {                          //(executes for any unregistered named route)
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },

      onUnknownRoute: (settings) //reached when flutter fails to build a screen (it's like a 404 error in web dev)
      {                          //(executes when onGenerateRoute is not defined or doesn't return a valid navigation action)
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },

    );
  }
}
