class AnexoCinco {
  final int anexoID;
  // INSTALACIÓN
  final String nombreInstalacion;
  final String idComponente;
  final String ubicacionInstalacion;
  final String equipoCritico;
  final String inspeccionTecnicaRiesgo;

  // INSPECCIÓN
  final String nombrePersonal;
  final String fechaInicioInspeccion;
  final String horaInicioInspeccion;
  final String fechafinalizacionInspeccion;
  final String horafinalizacionInspeccion;
  final String velocidadViento;
  final String temperatura;
  final String instrumentoUtilizado;
  final String fechaCalibracion;
  final String desviacionProcedimiento;
  final String justificacionDesviacion;
  final String interferenciaDeteccion;
  final String concentracionPrevia;
  final String reparado;

  // REPARADO SI
  final String fechaReparacion;
  final String horaReparacion;
  final String fechaComprobacionReparacion;
  final String horaComprobacionReparacion;
  final String concentracionPosteriorReparacion;

  // REPARADO NO
  final String noReparadofaltaComponentes;
  final String fechaRemisionComponente;
  final String fechaReperacionComponente;
  final String fechaRemplazoEquipo;
  final String volumenMetano;

  // FUGA = SI
  final String fuga;
  final String observacionPersonal;
  final String observacion;

  // IMAGENES
  final String imagen;
  final String imagenInfrarroja;

  // CAMPOS VACIOS
  final String anexoURL;
  final String informeURL;
  final String trimestre;
  // FORANEA
  final int clienteID;

  AnexoCinco({
    //INSTALACION
    required this.anexoID,
    required this.nombreInstalacion,
    required this.idComponente,
    required this.ubicacionInstalacion,
    required this.equipoCritico,
    required this.inspeccionTecnicaRiesgo,

    // INSPECCION
    required this.nombrePersonal,
    required this.fechaInicioInspeccion,
    required this.horaInicioInspeccion,
    required this.fechafinalizacionInspeccion,
    required this.horafinalizacionInspeccion,
    required this.velocidadViento,
    required this.temperatura,
    required this.instrumentoUtilizado,
    required this.fechaCalibracion,
    required this.desviacionProcedimiento,
    required this.justificacionDesviacion,
    required this.interferenciaDeteccion,
    required this.concentracionPrevia,
    required this.reparado,

    // REPARADO SI
    required this.fechaReparacion,
    required this.horaReparacion,
    required this.fechaComprobacionReparacion,
    required this.horaComprobacionReparacion,
    required this.concentracionPosteriorReparacion,

    // REPARADO NO
    required this.noReparadofaltaComponentes,
    required this.fechaRemisionComponente,
    required this.fechaReperacionComponente,
    required this.fechaRemplazoEquipo,
    required this.volumenMetano,

    //FUGA
    required this.fuga,
    required this.observacionPersonal,
    required this.observacion,

    // FOTOS
    required this.imagen,
    required this.imagenInfrarroja,

    // CAMPOS VACIOS
    required this.anexoURL,
    required this.informeURL,
    required this.trimestre,

    // CLIENTE ID
    required this.clienteID,
  });
  Map<String, dynamic> toMap() {
    return {
      'anexoID': anexoID,
      'nombreInstalacion': nombreInstalacion,
      'idComponente': idComponente,
      'ubicacionInstalacion': ubicacionInstalacion,
      'equipoCritico': equipoCritico,
      'inspeccionTecnicaRiesgo': inspeccionTecnicaRiesgo,

      // INSPECCION
      'nombrePersonal': nombrePersonal,
      'fechaInicioInspeccion': fechaInicioInspeccion,
      'horaInicioInspeccion': horaInicioInspeccion,
      'fechafinalizacionInspeccion': fechafinalizacionInspeccion,
      'horafinalizacionInspeccion': horafinalizacionInspeccion,
      'velocidadViento': velocidadViento,
      'temperatura': temperatura,
      'instrumentoUtilizado': instrumentoUtilizado,
      'fechaCalibracion': fechaCalibracion,
      'desviacionProcedimiento': desviacionProcedimiento,
      'justificacionDesviacion': justificacionDesviacion,
      'interferenciaDeteccion': interferenciaDeteccion,
      'concentracionPrevia': concentracionPrevia,
      'reparado': reparado,

      // REPARADO SI
      'fechaReparacion': fechaReparacion,
      'horaReparacion': horaReparacion,
      'fechaComprobacionReparacion': fechaComprobacionReparacion,
      'horaComprobacionReparacion': horaComprobacionReparacion,
      'concentracionPosteriorReparacion': concentracionPosteriorReparacion,

      // REPARADO NO
      'noReparadofaltaComponentes': noReparadofaltaComponentes,
      'fechaRemisionComponente': fechaRemisionComponente,
      'fechaReperacionComponente': fechaReperacionComponente,
      'fechaRemplazoEquipo': fechaRemplazoEquipo,
      'volumenMetano': volumenMetano,

      // FUGA
      'fuga': fuga,
      'observacionPersonal': observacionPersonal,
      'observacion': observacion,

      // IMAGENES
      'imagen': imagen,
      'imagenInfrarroja': imagenInfrarroja,

      // CAMPOS VACIOS
      'anexoURL': anexoURL,
      'informeURL': informeURL,
      'trimestre': trimestre,

      // CLIENTE
      'clienteID': clienteID,
    };
  }
}
