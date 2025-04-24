class StoreServiceModel {
  int? id;
  String? cliente;
  String? estado;
  String? producto;
  String? fechaServicio;

  StoreServiceModel({this.id,this.cliente,this.estado,this.producto,this.fechaServicio});

  factory StoreServiceModel.fromMap(Map<String, dynamic> map) {
    return StoreServiceModel(
      id: map['id'],
      cliente: map['cliente'],
      estado: map['estado'],
      producto: map['producto'],
      fechaServicio: map['fechaServicio']
    );
  }
}