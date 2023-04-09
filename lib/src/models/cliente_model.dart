class Cliente {
  final int clienteID;
  final String cliente;
  final String ciudad;
  final String trimestre;

  Cliente(
      {required this.cliente,
      required this.ciudad,
      required this.trimestre,
      required this.clienteID});

  Map<String, dynamic> toMap() {
    return {
      'clienteID': clienteID,
      'cliente': cliente,
      'ciudad': ciudad,
      'trimestre': trimestre,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      clienteID: map['clienteID'],
      cliente: map['cliente'],
      ciudad: map['ciudad'],
      trimestre: map['trimestre'],
    );
  }
}
