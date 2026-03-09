import 'package:flutter/material.dart';

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> photos = [
      'https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=300&auto=format&fit=crop', 
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ90jsbtsMjBkLaeQtjGxE3wT9uRRuX4qeFg&s', 
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=300&auto=format&fit=crop', 
      'https://images.unsplash.com/photo-1485921325833-c519f76c4927?q=80&w=300&auto=format&fit=crop', 
      'https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=300&auto=format&fit=crop', 
      'https://resuelveconbimbo-com-v2-assets.s3.amazonaws.com/s3fs-public/2024-04/Banner%20Desktop_Pan%20Tostado%20con%20Yogurt%20Griego%20y%20Frutas.png?VersionId=Gi0lInWeiAnOXj1su2yottxJ3VmFLNbg',
    ];


    return GridView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: photos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(photos[index], fit: BoxFit.cover),
        );
      },
    );
  }
}