
enum FurnitureType {land,air,hall}

class  Furniture {
  final String imageUrl;
// final FurnitureType type;

  Furniture({
    required this.imageUrl,
  //  required this .type,
  }); 
}

final Sofa = [
Furniture(
//  type: FurnitureType.land,
  imageUrl: 'Assets/Images/sofa.jpg',
),

Furniture(
//  type: FurnitureType.air,
  imageUrl: 'Assets/Images/sofa2.jpg',
),

Furniture(
//  type: FurnitureType.hall,
  imageUrl: 'Assets/Images/sofa11.jpg',
)

];


final Table = [
Furniture(
//  type: FurnitureType.land,
  imageUrl: 'Assets/Images/chair4.jpg',
),

Furniture(
//  type: FurnitureType.air,
  imageUrl: 'Assets/Images/chair5.jpg',
),

Furniture(
//  type: FurnitureType.hall,
  imageUrl: 'Assets/Images/chair6.jpg',
)

];