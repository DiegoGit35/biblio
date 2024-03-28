class Libro {
  final String codLibro, editorial, estadoFisico, disponibilidad, autores; 
  final String? fechaRegistro, fechaBaja;
  final int isbn;
  final int? idLibro; 

  Libro({
    required this.codLibro, 
    required this.editorial, 
    required this.estadoFisico, 
    required this.disponibilidad, 
    required this.autores, 
    required this.isbn,
    this.fechaRegistro, 
    this.fechaBaja,
    this.idLibro
  })

}
