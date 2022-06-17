import 'package:appdatec/components/button.dart';
import 'package:appdatec/models/products/computadoras/productos.dart';
import 'package:appdatec/providers/computadoras_provider.dart';
import 'package:appdatec/screens/products/computadoras/computadoras_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFormComScreen extends StatefulWidget {
  const ProductFormComScreen({Key? key}) : super(key: key);
  static String routeName = "/productoform";

  @override
  State<ProductFormComScreen> createState() => _ProductFormComScreenState();
}

enum Cat {hp, lenovo, apple, asus}

class _ProductFormComScreenState extends State<ProductFormComScreen> {

  final _formkey = GlobalKey<FormState>();
  final txtDescripcion = TextEditingController();
  final txtPrecio = TextEditingController();
  final txtImagen = TextEditingController();
  Cat? _catSeleccion = Cat.hp;
  bool? _estadoActivo = false;

  @override
  Widget build(BuildContext context) {
    final computoProvider = Provider.of<ComputoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTRO DE COMPUTADORAS'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(children: <Widget>[
              const SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Descripcion',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                ),
                controller: txtDescripcion,
                validator: (value){
                  if (value!.isEmpty){
                    return 'Por favor ingrese una descripcion';
                  }
                },
              ),
              const SizedBox(height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: txtPrecio,
                validator: (value){
                  if (value!.isEmpty){
                    return 'Por favor ingrese un valor';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'UriImagen',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: txtImagen,
                validator: (value){
                  if (value!.isEmpty){
                    return 'Por favor ingrese una url válida';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    const Text('Categoria'),
                    const SizedBox(
                      width: 20,
                    ),
                    Radio(
                        value: Cat.hp,
                        groupValue: _catSeleccion,
                        onChanged: (value){
                          setState((){
                            _catSeleccion = value as Cat?;
                            print(_catSeleccion);
                          });
                        }),
                    const Text('hp'),
                    const SizedBox(
                      width: 15,
                    ),
                    Radio(
                        value: Cat.lenovo,
                        groupValue: _catSeleccion,
                        onChanged: (value){
                          setState((){
                            _catSeleccion = value as Cat?;
                            print(_catSeleccion);
                          });
                        }),
                    const Text('Lenovo'),
                    const SizedBox(
                      width: 15,
                    ),
                    Radio(
                        value: Cat.apple,
                        groupValue: _catSeleccion,
                        onChanged: (value){
                          setState((){
                            _catSeleccion = value as Cat?;
                            print(_catSeleccion);
                          });
                        }),
                    const Text('Apple'),
                    const SizedBox(
                      width: 15,
                    ),
                    Radio(
                        value: Cat.asus,
                        groupValue: _catSeleccion,
                        onChanged: (value){
                          setState((){
                            _catSeleccion = value as Cat?;
                            print(_catSeleccion);
                          });
                        }),
                    const Text('Asus')
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  const Text('Estado'),
                  const SizedBox(
                    width: 20,
                  ),
                  Checkbox(
                      value: _estadoActivo,
                      onChanged: (value){
                        setState((){
                          _estadoActivo = value;
                          print('_estadoActivo: ${_estadoActivo}');
                        });
                      }),
                  const Text('Activo')
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Button(
                  text: 'Guardar',
                  press: (){
                    if (_formkey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Guardando...'),)
                      );
                      var producto = Producto(
                        id: '',
                        productoId: 0,
                        descripcion: txtDescripcion.text,
                        precio: int.parse(txtPrecio.text),
                        imagen: txtImagen.text,
                        categoria: _catSeleccion.toString(),
                        estado: _estadoActivo.toString(),
                      );

                      computoProvider.saveProducto(producto);

                      Navigator.pushReplacementNamed(
                          context, ProductoComScreen.routeName);
                    }
                  },
                ),
              )
            ],),
          ),
        ),
      ),
    );
  }
}
