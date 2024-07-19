// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';
import 'package:imovie_app/app/commons/imovie_ui/iui_grid_view.dart';
import 'package:imovie_app/app/series/interactor/serie_controller.dart';
import 'package:imovie_app/app/series/interactor/series_states.dart';

import '../commons/imovie_ui/iui_loader.dart';
import '../commons/imovie_ui/iui_text.dart';
import '../serie_details/ui/serie_details_screen.dart';
import 'ui/widgets/series_carousel_widge.dart';

class SeriesScreen extends StatelessWidget {
  SeriesScreen({super.key});

  final controller = SerieController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SeriesState>(
      valueListenable: controller..getSeries(),
      builder: (_, state, child) {
        return Scaffold(
          backgroundColor: const Color(0xff131418),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Loading state
              if (state is SeriesLoadingState)
                const Center(
                  heightFactor: 8,
                  child: IUILoader(
                    size: 50,
                    message: "Loading...",
                  ),
                ),

              // Error state
              if (state is SeriesErrorState)
                Center(
                  heightFactor: 14,
                  child: IUIText.heading(
                    state.message,
                    color: Colors.red,
                    fontsize: 15,
                  ),
                ).paddingOnly(left: 10, right: 10),

              if (state is SeriesLoadedState)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeriesCarouselWidget(series: state.series),
                      IUIText.title(
                        "Tv Series",
                        fontWeight: FontWeight.bold,
                      ).paddingOnly(left: 20, top: 10),
                      Expanded(
                        child: IUIGridView(
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 3,
                          mainAxisExtent: 200,
                          itemCount: state.series.length,
                          itemBuilder: (context, index) {
                            final serie = state.series[index];

                            return Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Modular.to.push(MaterialPageRoute(
                                        builder: (context) => SerieDetailsScreen(serie: serie),
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(serie.postImage),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
