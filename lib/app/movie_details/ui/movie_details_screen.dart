import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../_commons/app_services/utils.dart';
import '../../_commons/imovie_ui/iui_buttons.dart';
import '../../home/interactor/entities/movie.dart';
import '../data/movie_details_service.dart';
import 'widgets/cast_section.dart';
import 'widgets/movie_details_section.dart';
import 'widgets/photos_section.dart';
import 'widgets/videos_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({super.key, required this.movie});

  final service = Modular.get<MovieDetailsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // Image header
                Container(
                  height: 310,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movie.backgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                MovieDetailsSection(movie: movie),
                const SizedBox(height: 20),

                // Divider
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    endIndent: 35,
                    indent: 35,
                  ),
                ),

                const SizedBox(height: 10),

                CastSection(
                  id: movie.id,
                  service: service,
                ),
                const SizedBox(height: 10),
                VideosSection(
                  id: movie.id,
                  service: service,
                ),
                const SizedBox(height: 10),
                PhotosSection(
                  id: movie.id,
                  service: service,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            left: 10,
            child: IUIButtons.back(context),
          ),
        ],
      ),
    );
  }
}
