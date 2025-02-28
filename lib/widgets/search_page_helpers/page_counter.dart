import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';

class PageCounterRow extends StatefulWidget {
  const PageCounterRow({super.key});

  @override
  State<PageCounterRow> createState() => _PageCounterRowState();
}

class _PageCounterRowState extends State<PageCounterRow> {
  int value = GetIt.I<IAnimeTags>().pageValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          16,
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select on which page to search',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white, fontSize: 12,),
            ),
            Text(
              '-1 / -2 - will take random page, all other will be concrete page',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white, fontSize: 8,),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.end,spacing: 0,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Card(
                    margin: null,
                    elevation: 1,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          GetIt.I<IAnimeTags>()
                              .changeAmountOfPages(whatIncOrDec: 1);
                          setState(() {
                            value = GetIt.I<IAnimeTags>().pageValue;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_upward,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          GetIt.I<IAnimeTags>()
                              .changeAmountOfPages(whatIncOrDec: -1);
                          setState(() {
                            value = GetIt.I<IAnimeTags>().pageValue;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_downward,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 1,
                  margin: null,
                  child: IconButton(
                    onPressed: () {
                      GetIt.I<IAnimeTags>().clearAmountOfPages();
                      setState(() {
                        value = GetIt.I<IAnimeTags>().pageValue;
                      });
                    },
                    icon: Icon(
                      Icons.clear,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
