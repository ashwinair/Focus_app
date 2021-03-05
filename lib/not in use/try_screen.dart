// import 'package:Focus/screen2.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:clay_containers/constants.dart';
// import 'package:clay_containers/widgets/clay_containers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class Screen3 extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//       body: SafeArea(
//
//         child: Container(
//
//           child:
//               Column(
//                 children: <Widget>[
//                   SizedBox(height: 10,width: 20,),
//
//               Container(
//                 padding: EdgeInsets.all(20),
//                 alignment: FractionalOffset.topLeft,
//                 child: Text("Focus",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       fontSize: 35,
//                       color: const Color(0xFFD6D6D6)
//                   ),
//                 ),
//
//               ),
//               SizedBox(height: 8),
//               Container(
//                 width: 200,
//                 height: 100,
//
//                 child: Text("Study Mode",
//                 style: TextStyle(
//                   fontSize: 35,
//                   color: Colors.white60,
//                 ),
//                 ),
//
//               ),
//               // SizedBox(height: 70,width: 20,),
//               //
//               //
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text(
//                     'Missed calls',
//                     style: TextStyle(
//                       fontFamily: 'Meiryo UI',
//                       fontSize: 35.0,
//                       color: Colors.white60,
//                     ),
//                   ),
//
//                   Text(
//                     '0',
//                     style: TextStyle(
//                       fontFamily: 'Meiryo UI',
//                       fontSize: 35.0,
//                       color:
//                       const Color(0xFFFF0707).withOpacity(0.52),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//
//              //
//              SizedBox(
//                height:50,
//
//              ),
//
//               Padding(
//                 padding: const EdgeInsets.all(120),
//                 child: Row(
//                   children: <Widget>[
//                     Center(
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                            children: <Widget>[
//                              Hero(
//                                tag: "icon",
//                                child: AvatarGlow(
//                                  endRadius: 60,
//                                  shape: BoxShape.circle,
//                                  glowColor: Colors.green,
//                                  animate: true,
//                                  showTwoGlows: true,
//                                  curve: Curves.ease,
//                                  child: ClayContainer(
//                                    color: Color(0xFF1A1A1A),
//                                    height: 75,
//                                    depth: 6,
//                                    width: 75,
//                                    borderRadius: 150,
//                                    spread: 10,
//                                    curveType: CurveType.convex,
//
//                                    child: RawMaterialButton(
//                                      elevation: 2.0,
//                                      highlightColor: Colors.transparent,
//                                      splashColor: Colors.transparent,
//                                      onPressed: () {
//                                        Navigator.push(
//                                            context,
//                                            PageRouteBuilder(
//                                                transitionDuration: Duration(microseconds: 100),
//                                                pageBuilder: (_, __, ___) => Screen2()));
//
//                                      },
//                                      fillColor: const Color(0xFF1A1A1A),
//
//                                      child: SvgPicture.string(
//                                        // Icon awesome-power-off
//                                        '<svg viewBox="161.31 569.76 27.99 34.28" ><path transform="translate(160.74, 579.66)" d="M 22.682373046875 -1.012293577194214 C 26.23735237121582 1.5269775390625 28.5509090423584 5.680097103118896 28.5509090423584 10.38057136535645 C 28.5509090423584 18.09995460510254 22.29866218566895 24.35784912109375 14.58491802215576 24.37477684020996 C 6.882462024688721 24.39170837402344 0.5737831592559814 18.11124229431152 0.5624974966049194 10.40314292907715 C 0.5568546056747437 5.7026686668396 2.870413064956665 1.538263320922852 6.419750213623047 -1.006650924682617 C 7.07996129989624 -1.475005388259888 7.999741077423096 -1.277506351470947 8.394739151000977 -0.5721533298492432 L 9.28630542755127 1.013480663299561 C 9.619232177734375 1.605977058410645 9.461233139038086 2.356472969055176 8.91387939453125 2.762756824493408 C 6.572106838226318 4.500746250152588 5.076757907867432 7.254445552825928 5.076757907867432 10.37492942810059 C 5.071115016937256 15.58325576782227 9.280662536621094 19.86051750183105 14.5567045211792 19.86051750183105 C 19.72553253173828 19.86051750183105 24.07050704956055 15.67354202270508 24.03665161132813 10.31850051879883 C 24.01972198486328 7.395516872406006 22.64287376403809 4.574103832244873 20.19388580322266 2.757114410400391 C 19.64653205871582 2.350830554962158 19.49417495727539 1.600335597991943 19.82710266113281 1.013481616973877 L 20.71866989135742 -0.5721523761749268 C 21.11366653442383 -1.271862983703613 22.02780532836914 -1.480647325515747 22.682373046875 -1.012292861938477 Z M 16.81383323669434 10.83199691772461 L 16.81383323669434 -2.710783958435059 C 16.81383323669434 -3.461279630661011 16.21005058288574 -9.90447998046875 15.45955657958984 -9.90447998046875 L 15.45955657958984 -9.90447998046875 C 14.70906162261963 -9.90447998046875 12.29957389831543 -3.461279630661011 12.29957389831543 -2.710783958435059 L 12.29957389831543 10.83199691772461 C 12.29957389831543 11.58249282836914 12.90335655212402 12.18627548217773 13.65385150909424 12.18627548217773 L 15.45955657958984 12.18627548217773 C 16.21005058288574 12.18627548217773 16.81383323669434 11.58249282836914 16.81383323669434 10.83199691772461 Z" fill="#4fff1c" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                                        width: 20.99,
//                                        height:30.28,
//                                      ),
//                                      padding: EdgeInsets.all(16),
//                                      shape: CircleBorder(),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              // SizedBox(height: 60,width: 20,)
//                            ],
//
//                       ),
//                     ),
//                   ],
//                 )
//               ),
//
//                 ],
//               ),
//         ),
//       ),
//     );
//   }
//
// }
