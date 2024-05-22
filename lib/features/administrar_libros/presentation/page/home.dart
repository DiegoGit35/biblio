import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "biblio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: crearRegionCards(),
      ),
    );
  }
}

List<Widget> crearRegionCards() {
  List<Card> cards = [];

  cards
    ..add(crearCard(
        "[libros prestados1]", "[fecha prestamo1]", "[nombre socio1]"))
    ..add(crearCard(
        "[libros prestados2]", "[fecha prestamo2]", "[nombre socio2]"))
    ..add(crearCard(
        "[libros prestados3]", "[fecha prestamo3]", "[nombre socio3]"))
    ..add(crearCard(
        "[libros prestados4]", "[fecha prestamo4]", "[nombre socio4]"))
    ..add(crearCard(
        "[libros prestados5]", "[fecha prestamo5]", "[nombre socio5]"))
    ..add(crearCard(
        "[libros prestados6]", "[fecha prestamo6]", "[nombre socio6]"));
  return cards;
}

Card crearCard(String libroPrestado, String fechaPrestamo, String nombreSocio) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 4,
    child: Column(
      children: [
        const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          // child: Image.asset(
          //   'assets/images/book1.png',
          //   height: 250,
          //   // width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.fill,
          // ),
        ),
        ListTile(
          title: Text(
            libroPrestado,
            style: const TextStyle(fontSize: 20),
          ),
          trailing: Text(
            fechaPrestamo,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            nombreSocio,
            // style: TextStyle(fontSize: 20),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: TextButton(
        //     onPressed: () {},
        //     style: TextButton.styleFrom(
        //       backgroundColor: Colors.blue,
        //       // minimumSize: Size(MediaQuery.of(context).size.width, 56)
        //     ),
        //     child: const Text(
        //       'Add to cart',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // )
      ],
    ),
  );
}
