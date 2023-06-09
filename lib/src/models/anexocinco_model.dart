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
  final String fechaReparacionComponente;
  final String fechaRemplazoEquipo;
  final String volumenMetano;

  // FUGA = SI
  final String fuga;
  final String observacionPersonal;
  final String observacion;

  // IMAGENES
  String imagen;
  String imagenInfrarroja;

  // CAMPOS VACIOS
  final String anexoURL;
  final String informeURL;
  final String trimestre;

  // FECHA PARA ELIMINAR LOS DATOS
  final int fechaRegistro;
  int subidoNube;

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
    required this.fechaReparacionComponente,
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

    // fecha de creacion del map
    required this.fechaRegistro,
    required this.subidoNube,

    // CLIENTE ID
    required this.clienteID,
  });

  factory AnexoCinco.fromMap(Map<String, dynamic> map) {
    return AnexoCinco(
      anexoID: map['anexoID'],
      nombreInstalacion: map['nombreInstalacion'],
      idComponente: map['idComponente'],
      ubicacionInstalacion: map['ubicacionInstalacion'],
      equipoCritico: map['equipoCritico'],
      inspeccionTecnicaRiesgo: map['inspeccionTecnicaRiesgo'],
      nombrePersonal: map['nombrePersonal'],
      fechaInicioInspeccion: map['fechaInicioInspeccion'],
      horaInicioInspeccion: map['horaInicioInspeccion'],
      fechafinalizacionInspeccion: map['fechafinalizacionInspeccion'],
      horafinalizacionInspeccion: map['horafinalizacionInspeccion'],
      velocidadViento: map['velocidadViento'],
      temperatura: map['temperatura'],
      instrumentoUtilizado: map['instrumentoUtilizado'],
      fechaCalibracion: map['fechaCalibracion'],
      desviacionProcedimiento: map['desviacionProcedimiento'],
      justificacionDesviacion: map['justificacionDesviacion'],
      interferenciaDeteccion: map['interferenciaDeteccion'],
      concentracionPrevia: map['concentracionPrevia'],
      reparado: map['reparado'],
      fechaReparacion: map['fechaReparacion'],
      horaReparacion: map['horaReparacion'],
      fechaComprobacionReparacion: map['fechaComprobacionReparacion'],
      horaComprobacionReparacion: map['horaComprobacionReparacion'],
      concentracionPosteriorReparacion: map['concentracionPosteriorReparacion'],
      noReparadofaltaComponentes: map['noReparadofaltaComponentes'],
      fechaRemisionComponente: map['fechaRemisionComponente'],
      fechaReparacionComponente: map['fechaReparacionComponente'],
      fechaRemplazoEquipo: map['fechaRemplazoEquipo'],
      volumenMetano: map['volumenMetano'],
      fuga: map['fuga'],
      observacionPersonal: map['observacionPersonal'],
      observacion: map['observacion'],
      imagen: map['imagen'],
      imagenInfrarroja: map['imagenInfrarroja'],
      anexoURL: map['anexoURL'],
      informeURL: map['informeURL'],
      trimestre: map['trimestre'],
      fechaRegistro: map['fechaRegistro'],
      subidoNube: map['subidoNube'],
      clienteID: map['clienteID'],
    );
  }

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
      'fechaReparacionComponente': fechaReparacionComponente,
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

      //fECHA DE CREACION DE
      'fechaRegistro': fechaRegistro,
      'subidoNube': subidoNube,

      // CLIENTE
      'clienteID': clienteID,
    };
  }
}
