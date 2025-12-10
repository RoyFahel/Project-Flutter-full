class Medicament {
  final String? id;
  final String medicamentName;
  final String description;
  final String? maladyId;
  final String? maladyName; // For populated responses
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Medicament({
    this.id,
    required this.medicamentName,
    required this.description,
    this.maladyId,
    this.maladyName,
    this.createdAt,
    this.updatedAt,
  });

  // Convert from JSON (MongoDB response)
  factory Medicament.fromJson(Map<String, dynamic> json) {
    String? extractId(dynamic idField) {
      if (idField == null) return null;
      if (idField is Map && idField.containsKey(r'$oid')) return idField[r'$oid']?.toString();
      return idField.toString();
    }

    String? extractMaladyId(dynamic maladyField) {
      if (maladyField == null) return null;

      // If populated malady object
      if (maladyField is Map) {
        final nestedId = maladyField['_id'] ?? maladyField['id'];
        if (nestedId is Map && nestedId.containsKey(r'$oid')) return nestedId[r'$oid']?.toString();
        return nestedId?.toString();
      }

      // Fallback to string / ObjectId
      return maladyField.toString();
    }

    String? extractMaladyName(dynamic maladyField) {
      if (maladyField is Map) {
        return maladyField['maladyName']?.toString() ?? maladyField['name']?.toString();
      }
      return null;
    }

    return Medicament(
      id: extractId(json['_id'] ?? json['id']),
      medicamentName: json['medicamentName'] ?? json['name'] ?? '',
      description: json['description'] ?? '',
      maladyId: extractMaladyId(json['malady_id'] ?? json['maladyId']),
      maladyName: extractMaladyName(json['malady_id'] ?? json['maladyId']),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  // Convert to JSON (for MongoDB request)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'medicamentName': medicamentName,
      'description': description,
    };
    if (maladyId != null) data['malady_id'] = maladyId;
    if (id != null) data['_id'] = id;
    if (createdAt != null) data['createdAt'] = createdAt!.toIso8601String();
    if (updatedAt != null) data['updatedAt'] = updatedAt!.toIso8601String();
    return data;
  }

  // Copy with method for immutable updates
  Medicament copyWith({
    String? id,
    String? medicamentName,
    String? description,
    String? maladyId,
    String? maladyName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Medicament(
      id: id ?? this.id,
      medicamentName: medicamentName ?? this.medicamentName,
      description: description ?? this.description,
      maladyId: maladyId ?? this.maladyId,
      maladyName: maladyName ?? this.maladyName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Medicament(id: $id, medicamentName: $medicamentName, maladyName: $maladyName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Medicament && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
