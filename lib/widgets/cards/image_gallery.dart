part of '../widgets.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;
  final Function(String image)? deleteImage;
  const ImageGallery({
    super.key,
    required this.images,
    this.deleteImage,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png',
          fit: BoxFit.cover,
        ),
      );
    }
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: images.map((image) {
        late ImageProvider imageProvider;
        if (image.contains('http')) {
          imageProvider = NetworkImage(image);
        } else {
          imageProvider = FileImage(File(image));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              image.startsWith('/data')
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          if (deleteImage != null) {
                            deleteImage!(image);
                          }
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red[700],
                          size: 30,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }).toList(),
    );
  }
}
