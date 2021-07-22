import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function _setFilters;
  final Map<String, bool> _filters;

  FiltersScreen(this._filters, this._setFilters);


  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegeterian = false;
  bool _vegan = false;

  @override
  void initState() {
    _glutenFree = widget._filters['gluten'];
    _lactoseFree = widget._filters['lactose'];
    _vegeterian = widget._filters['vegetarian'];
    _vegan = widget._filters['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [IconButton(icon: Icon(Icons.save), onPressed: (){
            var _filteres = {
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegetarian': _vegeterian,
              'vegan': _vegan,
            };
             widget._setFilters(_filteres);
             })],
        ),
        drawer: MainDrawer(),
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text('Adjust Your Meal Selection',
                  style: Theme.of(context).textTheme.headline6),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              
              SwitchListTile(
                title: Text('Gluten-free'),
                subtitle: Text('Only include gluten-free meals.'),
                value: _glutenFree,
                onChanged: (newValue){
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              
              SwitchListTile(
                title: Text('Lactose-free'),
                subtitle: Text('Only include lactose-free meals.'),
                value: _lactoseFree,
                onChanged: (newValue){
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Vegetarian'),
                subtitle: Text('Only include vegetarian meals.'),
                value: _vegeterian,
                onChanged: (newValue){
                  setState(() {
                    _vegeterian = newValue;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Vegan'),
                subtitle: Text('Only include vegan meals.'),
                value: _vegan,
                onChanged: (newValue){
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
            ],
          ))
        ]));
  }
}
