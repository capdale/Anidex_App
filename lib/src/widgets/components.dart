import 'dart:math';

import 'package:anidex_app/src/root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;
import 'package:anidex_app/src/providers/_init.dart' as providers;

TableRow profileTableRow(
    BuildContext context, String label, String value, Widget? route) {
  return TableRow(
    children: [
      InkWell(
        onTap: () {
          if (route != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => route));
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 20, 5, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  Text(value,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600)),
                  Icon(Icons.chevron_right, color: Colors.grey, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Row contentRow(BuildContext context, String label, String value) {
  final padding = EdgeInsets.only(left: 20, top: 20, bottom: 20);
  return Row(children: [
    Flexible(
      flex: 4,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        child: Text(label,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black54)),
      ),
    ),
    Flexible(
      flex: 6,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        child: Text(value, style: TextStyle(fontSize: 22)),
      ),
    )
  ]);
}

Widget contentCategory(BuildContext context) {
  return Theme(
    data: ThemeData().copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      tilePadding: EdgeInsets.fromLTRB(20, 5, 15, 5),
      title: Text('분류',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black54)),
      initiallyExpanded: false,
      children: [
        categoryPadding('계', '동물계(Animalia)'),
        categoryPadding('문', '척삭동물문(Chordata)'),
        categoryPadding('강', '조강(Aves)'),
        categoryPadding('목', '참새목(Passeriformes)'),
        categoryPadding('과', '까마귀과(Corvidae)'),
        categoryPadding('속', '까치속(Pica)'),
        categoryPadding('종', '동양까치(P. serica)'),
      ],
    ),
  );
}

Row categoryPadding(String key, String value) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Container(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              key,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            )),
      ),
      Expanded(
        flex: 8,
        child: Container(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              value,
              style: TextStyle(fontSize: 20),
            )),
      )
    ],
  );
}

Widget sliderWidget(BuildContext context, Function(int) onPageChangedCallback) {
  return CarouselSlider(
      items:
          context.watch<providers.ContentInfo>().gridImageList.map((imgLink) {
        return Builder(
          builder: (context) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      imgLink,
                    )));
          },
        );
      }).toList(),
      options: CarouselOptions(
          height: 600,
          viewportFraction: 1.0,
          autoPlay: false,
          onPageChanged: (index, reason) {
            onPageChangedCallback(index);
          }));
}

Widget sliderIndicator(BuildContext context) {
  final CarouselController controller = CarouselController();
  return Align(
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: context
          .watch<providers.ContentInfo>()
          .gridImageList
          .asMap()
          .entries
          .map((entry) {
        return GestureDetector(
            onTap: () => controller.animateToPage(entry.key),
            child: Container(
              width: 10,
              height: 10,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(
                    context.watch<providers.ContentInfo>().current == entry.key
                        ? 0.9
                        : 0.4),
              ),
            ));
      }).toList(),
    ),
  );
}

class FavoriteAndShare extends StatefulWidget {
  const FavoriteAndShare({super.key});

  @override
  State<FavoriteAndShare> createState() => _FavoriteAndShareState();
}

class _FavoriteAndShareState extends State<FavoriteAndShare> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.deepPurple, width: 2)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline,
                  size: 40,
                )),
            Text(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                '좋아요 8,765개'),
            SizedBox(width: 4),
            SizedBox(
              width: 15,
              height: 35,
              child: VerticalDivider(
                color: Colors.deepPurple,
                thickness: 2,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  size: 40,
                )),
          ],
        ),
      ),
    );
  }
}

class ButtonData {
  final Color buttonColor;

  const ButtonData(this.buttonColor);
}

class DynamicAutoCompleteTags extends StatefulWidget {
  const DynamicAutoCompleteTags({super.key});

  @override
  State<DynamicAutoCompleteTags> createState() =>
      _DynamicAutoCompleteTagsState();
}

class _DynamicAutoCompleteTagsState extends State<DynamicAutoCompleteTags> {
  late double _distanceToField;
  late DynamicTagController<DynamicTagData<ButtonData>> _dynamicTagController;
  final random = Random();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _dynamicTagController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dynamicTagController = DynamicTagController<DynamicTagData<ButtonData>>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Autocomplete<DynamicTagData<ButtonData>>(
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topCenter,
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DynamicTagData<ButtonData> option =
                            options.elementAt(index);
                        return TextButton(
                          onPressed: () {
                            onSelected(option);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '#${option.tag}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 74, 137, 92),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFieldTags<DynamicTagData<ButtonData>>(
                textfieldTagsController: _dynamicTagController,
                textEditingController: textEditingController,
                focusNode: focusNode,
                textSeparators: const [' ', ','],
                letterCase: LetterCase.normal,
                validator: (DynamicTagData<ButtonData> tag) {
                  if (_dynamicTagController.getTags!
                      .any((element) => element.tag == tag.tag)) {
                    return '이미 입력된 태그입니다.';
                  }
                  return null;
                },
                inputFieldBuilder: (context, inputFieldValues) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: inputFieldValues.textEditingController,
                      focusNode: inputFieldValues.focusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: inputFieldValues.tags.isNotEmpty
                            ? ''
                            : "태그를 입력해 주세요.",
                        hintStyle: TextStyle(fontSize: 20),
                        errorText: inputFieldValues.error,
                        prefixIconConstraints:
                            BoxConstraints(maxWidth: _distanceToField * 0.74),
                        prefixIcon: inputFieldValues.tags.isNotEmpty
                            ? SingleChildScrollView(
                                controller:
                                    inputFieldValues.tagScrollController,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: inputFieldValues.tags
                                        .map((DynamicTagData<ButtonData> tag) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      color: tag.data.buttonColor,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Text(
                                            tag.tag,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                          onTap: () {
                                            print("${tag.tag} selected");
                                          },
                                        ),
                                        const SizedBox(width: 4.0),
                                        InkWell(
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 14.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          onTap: () {
                                            inputFieldValues.onTagRemoved(tag);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }).toList()),
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        final getColor = Color.fromARGB(
                            random.nextInt(256),
                            random.nextInt(256),
                            random.nextInt(256),
                            random.nextInt(256));
                        final button = ButtonData(getColor);
                        final tagData = DynamicTagData(value, button);
                        inputFieldValues.onTagChanged(tagData);
                      },
                      onSubmitted: (value) {
                        final getColor = Color.fromARGB(
                            random.nextInt(256),
                            random.nextInt(256),
                            random.nextInt(256),
                            random.nextInt(256));
                        final button = ButtonData(getColor);
                        final tagData = DynamicTagData(value, button);
                        inputFieldValues.onTagSubmitted(tagData);
                      },
                    ),
                  );
                },
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              return const Iterable<DynamicTagData<ButtonData>>.empty();
            },
            onSelected: (option) {
              _dynamicTagController.onTagSubmitted(option);
            },
          ),
        ],
      ),
    );
  }
}

void showSignUpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "일치하는 메일 주소가 없습니다.\n이 메일 주소로 가입하시겠어요?",
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurpleAccent),
            child: Text(
              "아니오",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text(
              "예",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => pages.SignUp()));
            },
          ),
        ],
      );
    },
  );
}

void showMessageDialog(BuildContext context, String message,
    {bool popAll = false}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(message, style: TextStyle(fontSize: 20)),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (popAll) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const Root()),
                          (route) => false);
                    }
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        );
      });
}

Widget articleMenu(BuildContext context, double iconSize, bool articleOwn) {
  return Center(
    child: PopupMenuButton(
      surfaceTintColor: Colors.white,
      iconSize: iconSize,
      itemBuilder: (context) {
        return articleOwn
            ? [
                PopupMenuItem(
                    child: Text(
                      '수정',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      print('수정 선택');
                    }),
                PopupMenuItem(
                  child: Text(
                    '삭제',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    showDeleteDialog(context, '게시글');
                  },
                ),
              ]
            : [
                PopupMenuItem(
                    child: Text(
                      '신고',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      print('신고 선택');
                    }),
              ];
      },
    ),
  );
}

Widget commentMenu(BuildContext context, double iconSize, bool commentOwn) {
  return Center(
    child: PopupMenuButton(
      surfaceTintColor: Colors.white,
      icon: Icon(Icons.more_horiz),
      iconSize: iconSize,
      itemBuilder: (context) {
        return commentOwn
            ? [
                PopupMenuItem(
                  child: Text(
                    '삭제',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    showDeleteDialog(context, '댓글');
                  },
                ),
              ]
            : [
                PopupMenuItem(
                    child: Text(
                      '신고',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      showReportDialog(context);
                    }),
              ];
      },
    ),
  );
}

void showDeleteDialog(BuildContext context, String what) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10) // Set the border radius here
          ),
          title: Text('삭제된 $what은 복구할 수 없습니다. 정말로 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소', style: TextStyle(fontSize: 22)),
              onPressed: () {
                print('Deleting post');
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                '확인',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      });
}

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String? selectedReportType;
  List<String> reportTypes = ['부적절한 내용', '욕설/비방', '광고', '기타'];
  bool addWhy = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10) // Set the border radius here
          ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '신고 사유를 선택해 주세요.',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedReportType,
              items: reportTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 22)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedReportType = newValue;
                  if (selectedReportType == '기타') {
                    addWhy = true;
                  }
                });
              },
            ),
            SizedBox(height: 5,),
            addWhy ? SizedBox(
              height: 200,
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '내용 입력',
                  hintStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder()
                ),
                maxLines: 4,
                maxLength: 60,
                style: TextStyle(fontSize: 20),
              ),
            ) : Container()
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            '취소',
            style: TextStyle(fontSize: 22),
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Close the dialog without doing anything
          },
        ),
        TextButton(
          child: Text(
            '신고하기',
            style: TextStyle(fontSize: 22),
          ),
          onPressed: () {
            print(
                'Reporting as: $selectedReportType'); // Handle the report action
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}

void showReportDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog();
      });
}

