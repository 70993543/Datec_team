import 'package:appdatec/models/products/celulares/moviles.dart';
import 'package:appdatec/providers/celulares_provider.dart';
import 'package:appdatec/screens/drawer/menu_lateral.dart';
import 'package:appdatec/screens/products/celulares/form/cel_form.dart';
import 'package:appdatec/screens/products/celulares/report/report_celular_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class MovilesCelScreen extends StatefulWidget {
  const MovilesCelScreen({Key? key}) : super(key: key);
  static String routeName = "/movilScreen";

  @override
  State<MovilesCelScreen> createState() => _MovilesCelScreen();
}

class _MovilesCelScreen extends State<MovilesCelScreen> {
  @override
  Widget build(BuildContext context) {

    final productoProvider = Provider.of<CelularProvider>(context);
    final List<Producto> listaProductos = productoProvider.listaProductos.cast<Producto>();


    return Scaffold(
      appBar: AppBar(
        title: const Text("Celulares"),
      ),
      drawer: const MenuLateral(),
      body: Center(
        child: ListView.builder(
          itemCount: listaProductos.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                width: double.infinity,
                height: 300,
                decoration: _cardBorders(),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/images/R.gif'),
                          image: NetworkImage(listaProductos[index].imagen),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(listaProductos[index].descripcion,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                        subtitle: Text('S/. ${listaProductos[index].precio}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
              ,
            );
          },
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        hoverColor: kPrimaryColor,
        onPressed: (){
          Navigator.pushNamed(context, ProductFormComScreen.routeName);
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),*/
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          spacing: 12,
          spaceBetweenChildren: 12,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.pie_chart),
              label: 'reporte',
              onTap: () => Navigator.pushNamed(context, CelularesReportScreen.routeName),
            ),
            SpeedDialChild(
                child: const Icon(Icons.computer),
                label: 'form',
              onTap: () => Navigator.pushNamed(context, CelularesForm.routeName),
            ),
          ],
      ),
    );
  }
}

BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 7),
          blurRadius: 10
      )
    ]
);