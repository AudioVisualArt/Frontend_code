// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:Clapp/main.dart';
import 'package:Clapp/src/NewHome/Pages/home_page_principal.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/widgets/menu_widget.dart';
import 'package:Clapp/src/projectos/pages/recomendados_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

 

void main() {
    UserModel user=UserModel(
    email: "email",
    description: "description",
    name:"this.name",
    age: 3,
    cityResidence:"this.cityResidence",
    id:"this.id",
    rating:2323,
    photoUrl:"this.photoUrl"
  );
  testWidgets("login page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  testWidgets('Home Page test', (WidgetTester tester) async {
     final key = GlobalKey<NavigatorState>();
    await tester.pumpWidget(MaterialApp(
      navigatorKey: key,
      home: FlatButton(   
          onPressed: (){
            key.currentState.push(
             MaterialPageRoute<void>(
            settings: RouteSettings(arguments: user),
            builder: (_) => HomePagePrincipal(),
          ));
          },
          child: const SizedBox(),
       
      ),
    ));
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    expect(find.text('Menú Principal'), findsOneWidget);
    expect(find.text('Estudio'), findsOneWidget);
  });
  testWidgets("Mercado Page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  testWidgets("Servicios Page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  testWidgets("Project page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  testWidgets("Recomendados Page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  testWidgets("Equipment Page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  testWidgets("Space Page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  testWidgets("Message Page", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    expect(find.text("Bienvenido a Clapp"),findsOneWidget);
    expect(find.byType(TextField),findsNWidgets(2));

  });
  
}
