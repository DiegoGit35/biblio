class Libro {
  late String anio,
      titulo,
      editorial,
      estadoFisico,
      disponibilidad,
      fechaRegistro,
      autores,
      isbn;
  String? fechaBaja, idLibro;

  Libro(this.anio, this.titulo, this.editorial, this.estadoFisico,
      this.disponibilidad, this.fechaRegistro, this.autores, this.isbn);
}
