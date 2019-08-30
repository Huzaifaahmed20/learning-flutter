import 'package:flutter/material.dart';
import '../dummy-data.dart';

class SingleMealDetail extends StatelessWidget {
  static const routeName = '/single-meal-detail';

  Widget _buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '$text',
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  Widget _buildContainer({Widget child}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        height: 150,
        width: 300,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
        appBar: AppBar(
          title: Text('${selectedMeal.title}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              _buildSectionTitle(context, 'Ingredients'),
              _buildContainer(
                child: ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).primaryColorDark,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          selectedMeal.ingredients[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildSectionTitle(context, 'Steps'),
              _buildContainer(
                  child: ListView.builder(
                      itemCount: selectedMeal.steps.length,
                      itemBuilder: (ctx, index) => Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  child: Text('# ${index + 1}'),
                                ),
                                title: Text(selectedMeal.steps[index]),
                              ),
                              Divider(
                                color: Colors.black,
                              )
                            ],
                          )))
            ],
          ),
        ));
  }
}
