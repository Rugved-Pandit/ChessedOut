import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:snack/snack.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var text1 = '3';
  static var text2 = 0;
  //var icon1 = Icon(Icons.phone);
  static var temp1 = Text("♕", style: TextStyle(fontSize: 40),);
  static var temp2 = Text("♚", style: TextStyle(fontSize: 40),);

  //PIECES 
  static const emptyBox = Tab(child: Image(image: AssetImage('')),);//Text("", style: TextStyle(fontSize: 40),);

  static const wK = Tab(child: Image(image: AssetImage('assets/wK-icon.png')),);// Text("♔", style: TextStyle(fontSize: 40),);
  static const wQ = Tab(child: Image(image: AssetImage('assets/wQ-icon.png')),);// Text("♕", style: TextStyle(fontSize: 40),);
  static const wR = Tab(child: Image(image: AssetImage('assets/wR-icon.png')),);// Text("♖", style: TextStyle(fontSize: 40),);
  static const wB = Tab(child: Image(image: AssetImage('assets/wB-icon.png')),);// Text("♗", style: TextStyle(fontSize: 40),);
  static const wN = Tab(child: Image(image: AssetImage('assets/wN-icon.png')),);// Text("♘", style: TextStyle(fontSize: 40),);
  static const wP = Tab(child: Image(image: AssetImage('assets/wP-icon.png')),);// Text("♙", style: TextStyle(fontSize: 25),);

  static const bK = Tab(child: Image(image: AssetImage('assets/bK-icon.png')),);// Text("♚", style: TextStyle(fontSize: 40),);
  static const bQ = Tab(child: Image(image: AssetImage('assets/bQ-icon.png')),);// Text("♛", style: TextStyle(fontSize: 40),);
  static const bR = Tab(child: Image(image: AssetImage('assets/bR-icon.png')),);// Text("♜", style: TextStyle(fontSize: 40),);
  static const bB = Tab(child: Image(image: AssetImage('assets/bB-icon.png')),);// Text("♝", style: TextStyle(fontSize: 40),);
  static const bN = Tab(child: Image(image: AssetImage('assets/bN-icon.png')),);// Text("♞", style: TextStyle(fontSize: 40),);
  static const bP = Tab(child: Image(image: AssetImage('assets/bP-icon.png')),);// Text("♟", style: TextStyle(fontSize: 25),);

  static const attackBox = Text("O", style: TextStyle(fontSize: 30,color: Colors.grey),);
  static var legalMoveBox = 13;//attackBox;
  static var tempPiece;
  var oldNo;
  var promoNo;
  bool callFlushbar = false;
  
  var legalMoveBorder;
  static var attackBorder = Border.all(width: 3, color: Colors.red);
  static var notAttackBorder = null;//Border.all(width: 3, color: Colors.green);

  //Lists

  static const list_of_pieces = [
    bR, bN, bB, bQ, bK, bP, 
    wR, wN, wB, wQ, wK, wP,
    emptyBox, attackBox, 
  ];

  // static const list_of_pieces = [
  //   bR1, bN1, bB1, bQ, bK, bB2, bN2, bR2, 
  //   bP1, bP2, bP3, bP4, bP5, bP6, bP7, bP8,
  //   wP1, wP2, wP3, wP4, wP5, wP6, wP7, wP8,
  //   wR1, wN1, wB1, wQ, wK, wB2, wN2, wR2, 
  //   emptyBox, attackBox, 
  // ];
  // static const a=1.1, b=1.2;//, c=11, d=12, e=12, f=13, g=14, h=15;  //a = wR, b=wN, c=wB, d=wQ, e=wK, f=wB, g=wN, h=wR, i=wP;
  var list_of_whites = [wR, wN, wB, wQ, wK, wP];
  var list_of_blacks = [bR, bN, bB, bQ, bK, bP];
  var list_of_borders = [
    0, 1, 2, 3, 4, 5, 6, 7, 
    8, 16, 24, 32, 40, 48, 
    15, 23, 31, 39, 47, 55, 
    56, 57, 58, 59, 60, 61, 62, 63
  ];
  var list_of_north_border = [0, 1, 2, 3, 4, 5, 6, 7];
  var list_of_south_border = [56, 57, 58, 59, 60, 61, 62, 63];
  var list_of_east_border = [7, 15, 23, 31, 39, 47, 55, 63];
  var list_of_west_border = [0, 8, 16, 24, 32, 40, 48, 56];
  var legalMovesList = [];
  List<int> array4 = [
    0, 1, 2, 3, 4, 2, 1, 0,
    5, 5, 5, 5, 5, 5, 5, 5,
    12, 12, 12, 12, 12, 12, 12, 12, 
    12, 12, 12, 12, 12, 12, 12, 12, 
    12, 12, 12, 12, 12, 12, 12, 12, 
    12, 12, 12, 12, 12, 12, 12, 12,
    11, 11, 11, 11, 11, 11, 11, 11,
    6, 7, 8, 9, 10, 8, 7, 6
  ];

  // List<int> array4 = [
  //   0, 1, 2, 3, 4, 5, 6, 7,
  //   8, 9, 10, 11, 12, 13, 14, 15, 
  //   32, 32, 32, 32, 32, 32, 32, 32,
  //   32, 32, 32, 32, 32, 32, 32, 32,
  //   32, 32, 32, 32, 32, 32, 32, 32,
  //   32, 32, 32, 32, 32, 32, 32, 32,
  //   16, 17, 18, 19, 20, 21, 22, 23,
  //   24, 25, 26, 27, 28, 29, 30, 31
  // ];
  
  /*var array4 = [
    bR, bN, bB, bQ, bK, bB, bN, bR, 
    bP, bP, bP, bP, bP, bP, bP, bP, 
    emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, 
    emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, 
    emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, 
    emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, emptyBox, 
    wP, wP, wP, wP, wP, wP, wP, wP, 
    wR, wN, wB, wQ, wK, wB, wN, wR, 
  ];*/

  var borders = [
    null, null, null, null, null, null, null, null, 
    null, null, null, null, null, null, null, null, 
    null, null, null, null, null, null, null, null, 
    null, null, null, null, null, null, null, null, 
    null, null, null, null, null, null, null, null, 
    null, null, null, null, null, null, null, null, 
    null, null, null, null, null, null, null, null, 
    null, null, null, null, null, null, null, Border.all(width: 0, color: Colors.red), 
  ];

  //TEMPORARY ASSIGNMENTS


  //Counters
  var turn_counter = 0;
  var move_displayer = 0;
  var pieceCounter1 = 0;
  var pieceCounter2 = 0;

  
  //attackBoxListOfWhite[0] = 2; //array4.indexOf(wQ);

  //The Functions
  void movement (var number) {
    if(pieceCounter1 %2 ==0) {
      if(turn_counter %2 ==0) {
        legal_moves_displayer_for_white(number);
      }
      if(turn_counter %2 !=0) {
        legal_moves_displayer_for_black(number);
      }
      //legal_moves_displayer(number);
    }
    else {
      borders[oldNo] = null;
      if(legalMovesList.contains(number)) {
        array4[number] = tempPiece;
        //PUT IT RIGHT HERE //NO A LITTLE BELOW
        
        turn_counter++;
        array4[oldNo] = 12;//emptyBox;
        borders[oldNo] = notAttackBorder;
        borders[number] = notAttackBorder;
        legalMovesList.remove(number);

        //YES, RIGHT HERE
        //check part
        if(turn_counter%2 == 1) {
          if(reverse_check_finder_for_bK(array4.indexOf(4))) {
            ch.show(context);
          }
        }
        if(turn_counter%2 == 0) {
          if(reverse_check_finder_for_wK(array4.indexOf(10))) {
            ch.show(context);
          }
        }

        //castling part 
        if(array4[number] == 10) {
          castleWhite();
        }
        if(array4[number] == 4) {
          castleBlack();
        }

        //pawn promotion part
        if(array4[number] == 11) {
          if(list_of_north_border.contains(number)) {
            promoNo = number;
            callFlushbar = true;            
          }
        }
        if(array4[number] == 5) {
          if(list_of_south_border.contains(number)) {
            promoNo = number;
            callFlushbar = true;            
          }
        }

        //attack_box_teller_of_white();
        //attack_box_teller_of_black();
      }
      for(var x=0; x<legalMovesList.length; x++) {
        if( !list_of_blacks.contains(list_of_pieces[array4[legalMovesList[x]]] ) && !list_of_whites.contains(list_of_pieces[array4[legalMovesList[x]]] )) {
          array4[legalMovesList[x]] = 12;//emptyBox;
        }
        borders[legalMovesList[x]] = notAttackBorder;
      }
      legalMovesList = [];
      //pieceCounter1++;
      move_displayer++;
      //pieceCounter1--;
      //attack_box_teller(number); /*So many troubles for so little work*/
    }
    pieceCounter1++;
    
    //MAKING NEW FUNCTION FOR CHECK
    //attack_box_teller();
  }

  void legal_moves_displayer_for_white (var number) {
    borders[number] = Border.all(width: 4, color: Colors.yellow);
    move_displayer++;
    legalMovesList = [];
    if(move_displayer % 2 !=0) {
      legalMoveBox =13;//attackBox;
      legalMoveBorder = attackBorder;
    }
    else {
      legalMoveBox = 12;//emptyBox;
      legalMoveBorder = notAttackBorder;
    }
    switch (array4[number]) {
      case 6: {
        text2++;
        wRcase(number);
        //NEW addition
        tempPiece = 6;
        oldNo = number;
      } break; //wR END
      case 8: {
        text2++;
        wBcase(number);
        tempPiece = 8;
        oldNo = number;
      }break;//wB END
      case 9: {
        text2++;
        wRcase(number);
        //Bishop part
        wBcase(number);
        tempPiece = 9;
        oldNo = number;
      } break; //wQ END
      case 7: {
        text2++;
        wNcase(number);
        tempPiece = 7;
        oldNo = number;
      } break; //wN END
      case 11: {
        text2++;
        wPcase(number);
        tempPiece = 11;
        oldNo = number;
      } break; // wP END
      case 10: {
        text2++;
        var kingSquares = caseK(number);
        //bK boxes part
        var kingSquares_OppositeK = caseK(array4.indexOf(4));
        var kingSquares_Opp_attackList = [];
        for(var x =0; x < kingSquares_OppositeK.length; x++) {
          var tempNo3 = array4.indexOf(4) + kingSquares_OppositeK[x];
          if(0<= tempNo3 && tempNo3 <=63) {
            kingSquares_Opp_attackList.add(tempNo3);
          }
        }

        for(var x =0; x < kingSquares.length; x++) {
          var tempNo2 = number + kingSquares[x];
          if(0<= tempNo2 && tempNo2 <=63) {
            if(!list_of_whites.contains(list_of_pieces[array4[tempNo2]] )) {
              if(!reverse_check_finder_for_wK(tempNo2)) {
                if(!kingSquares_Opp_attackList.contains(tempNo2)) {
                  if(list_of_blacks.contains(list_of_pieces[array4[tempNo2]] )) {
                    legalMovesList.add(tempNo2);
                    borders[tempNo2] = legalMoveBorder;
                    continue;
                  }
                  array4[tempNo2] = legalMoveBox;
                  borders[tempNo2] = legalMoveBorder;
                  legalMovesList.add(tempNo2);
                }
              }
            }
          }
        }

        //castling part
        if(castlingAllowedForWhite){
          if(castlingAllowedKingSideForWhite) {
            if(legalMovesList.contains(61)) {
              if(array4[62] == 12) {
                if(!reverse_check_finder_for_wK(60)) {
                  if(!reverse_check_finder_for_wK(62)) {
                    if(!kingSquares_Opp_attackList.contains(62)) {
                      legalMovesList.add(62);
                      borders[62] = legalMoveBorder;
                      array4[62] = legalMoveBox;
                    }
                  }
                }
              }
            }
          }
          if(castlingAllowedQueenSideForWhite) {
            if(legalMovesList.contains(59)) {
              if(array4[58] == 12 || array4[57] == 12 ) {
                if(!reverse_check_finder_for_wK(60)) {
                  if(!reverse_check_finder_for_wK(58)) {
                    if(!kingSquares_Opp_attackList.contains(58)) {
                      legalMovesList.add(58);
                      borders[58] = legalMoveBorder;
                      array4[58] = legalMoveBox;
                    }
                  }
                }
              }
            }
          }
        }

        tempPiece = 10;
        oldNo = number;
      } break; //wK Work Going On
      default : {
        move_displayer++;
        pieceCounter1++;
        text2++;
        borders[number] = null;
      } 
    }
  }//LMD White END

  void legal_moves_displayer_for_black (var number) {
    borders[number] = Border.all(width: 4, color: Colors.yellow);
    move_displayer++;
    legalMovesList = [];
    if(move_displayer % 2 !=0) {
      legalMoveBox = 13;//attackBox;
    }
    else {
      legalMoveBox = 12;//emptyBox;
    }
    switch (array4[number]) {
      case 0: {
        text2++;
        bRcase(number);
        //NEW additon
        tempPiece = 0;
        oldNo = number;
      } break; //bR END
      case 2: {
        text2++;
        bBcase(number);
        tempPiece = 2;
        oldNo = number;
      } break;//bB END
      case 3: {
        text2++;
        bRcase(number);
        //Bishop part
        bBcase(number);
        tempPiece = 3;
        oldNo = number;
      } break;//bQ END
      case 1 : {
        text2++;
        bNcase(number);
        tempPiece = 1;
        oldNo = number;
      } break; //bN END
      case 5: {
        text2++;
        bPcase(number);
        tempPiece = 5;
        oldNo = number;
      } break; // bP END
      case 4: {
        text2++;
        var kingSquares = caseK(number);
        //wK boxes part
        var kingSquares_OppositeK = caseK(array4.indexOf(10));
        var kingSquares_Opp_attackList = [];
        for(var x =0; x < kingSquares_OppositeK.length; x++) {
          var tempNo3 = array4.indexOf(10) + kingSquares_OppositeK[x];
          if(0<= tempNo3 && tempNo3 <=63) {
            kingSquares_Opp_attackList.add(tempNo3);
          }
        }
        
        for(var x =0; x < kingSquares.length; x++) {
          var tempNo2 = number + kingSquares[x];
          if(0<= tempNo2 && tempNo2 <=63) {
            if(!list_of_blacks.contains(list_of_pieces[array4[tempNo2]] )) {
              if(!reverse_check_finder_for_bK(tempNo2)) {
                if(!kingSquares_Opp_attackList.contains(tempNo2)) {
                  if(list_of_whites.contains(list_of_pieces[array4[tempNo2]] )) {
                    legalMovesList.add(tempNo2);
                    borders[tempNo2] = legalMoveBorder;
                    continue;
                  }
                  array4[tempNo2] = legalMoveBox;
                  borders[tempNo2] = legalMoveBorder;
                legalMovesList.add(tempNo2);
                }
              }
            }
          }
        }

        //castling part
        if(castlingAllowedForBlack){
          if(castlingAllowedKingSideForBlack) {
            if(legalMovesList.contains(5)) {
              if(array4[6] == 12) {
                if(!reverse_check_finder_for_bK(4)) {
                  if(!reverse_check_finder_for_bK(6)) {
                    if(!kingSquares_Opp_attackList.contains(6)) {
                      legalMovesList.add(6);
                      borders[6] = legalMoveBorder;
                      array4[6] = legalMoveBox;
                    }
                  }
                }
              }
            }
          }
          if(castlingAllowedQueenSideForBlack) {
            if(legalMovesList.contains(3)) {
              if(array4[2] == 12 || array4[1] == 12 ) {
                if(!reverse_check_finder_for_bK(4)) {
                  if(!reverse_check_finder_for_bK(2)) {
                    if(!kingSquares_Opp_attackList.contains(2)) {
                      legalMovesList.add(2);
                      borders[2] = legalMoveBorder;
                      array4[2] = legalMoveBox;
                    }
                  }
                }
              }
            }
          }
        }
        tempPiece = 4;
        oldNo = number;
      } break; //bK Work Going On
      default : {
        move_displayer++;
        pieceCounter1++;
        text2++;
        borders[number] = null;
      } 
    }
  }//LMD Black END

  //Piece Functions

  void wRcase (number) {
    var tempNo1 = number;
        for (tempNo1= number + 1; tempNo1 < (number - (number%8) +8 ) ; tempNo1++) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }          
          var zz = array4[number];//this additon is for the illegal move prevention
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[tempNo1] = 12;
          array4[number] = zz;     
        }
        for (tempNo1= number - 1; tempNo1 >= (number - (number%8) ) ; tempNo1--) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }
          var zz = array4[number];
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[tempNo1] = 12;
          array4[number] = zz;
        }
        for (tempNo1= number - 8; tempNo1 >= (number%8) ; tempNo1-=8) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }
          var zz = array4[number];
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[tempNo1] = 12;
          array4[number] = zz;
        }
        for (tempNo1= number + 8; tempNo1 <= 56+(number%8) ; tempNo1+=8) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }          
          var zz = array4[number];
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[tempNo1] = 12;
          array4[number] = zz;            
        }
  } //wRcase end

  void wBcase (number) {
    var tempNo1 = number;
    if(!list_of_east_border.contains(number)) {
          for (tempNo1= number -7; ; tempNo1-=7) {
            if(tempNo1 < 0) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;  
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_east_border.contains(number)) {
          for (tempNo1= number +9; ; tempNo1+=9) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder; 
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number +7; ; tempNo1+=7) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number -9; ; tempNo1-=9) {
            if(tempNo1 <0) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
  } //wBcase end

  void wNcase (number) {
    var tempNo1 = number;
        var knightSquares;
        var knightSquares1 = [-10, -17, -15, -6, 10, 17, 15, 6];
        var knightSquares2 = [17, 10];
        var knightSquares3 = [-6, 10, 17];
        var knightSquares4 = [-15, -6, 10];
        var knightSquares5 = [-15, -6];
        var knightSquares6 = [-15, -6, 10, 17];
        var knightSquares7 = [17, 10, 15];
        var knightSquares8 = [17, 10, 15, -6];
        var knightSquares9 = [10, -6, -15, -17];
        var knightSquares10 = [-6, -15, -17];
        var knightSquares11 = [10, -6, -15, -17, 17, 15];
        var knightSquares12 = [6, 15, 17];
        var knightSquares13 = [6, 15, 17, -10];
        var knightSquares14 = [6, -10, -15, -17];
        var knightSquares15 = [-10, -17, -15];
        var knightSquares16 = [6, -10, -17, -15, 17, 15];
        var knightSquares17 = [6, 15];
        var knightSquares18 = [-10, 6, 15];
        var knightSquares19 = [6, -10, -17];
        var knightSquares20 = [-10, -17];
        var knightSquares21 = [15, 6, -10, -17];
        switch (number%8) {
          case 0:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares2;
              } break;
              case 8:{
                knightSquares = knightSquares3;
              } break;
              case 48:{
                knightSquares = knightSquares4;
              } break;
              case 56:{
                knightSquares = knightSquares5;
              } break;
              default : {
                knightSquares = knightSquares6;
              }
            }
          } break;
          case 1:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares7;
              } break;
              case 8:{
                knightSquares = knightSquares8;
              } break;
              case 48:{
                knightSquares = knightSquares9;
              } break;
              case 56:{
                knightSquares = knightSquares10;
              } break;
              default :{
                knightSquares = knightSquares11;
              }
            }
          } break;
          case 6:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares12;
              } break;
              case 8:{
                knightSquares = knightSquares13;
              } break;
              case 48:{
                knightSquares = knightSquares14;
              } break;
              case 56:{
                knightSquares = knightSquares15;
              } break;
              default : {
                knightSquares = knightSquares16;
              }
            }
          } break;
          case 7:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares17;
              } break;
              case 8:{
                knightSquares = knightSquares18;
              } break;
              case 48:{
                knightSquares = knightSquares19;
              } break;
              case 56:{
                knightSquares = knightSquares20;
              } break;
              default :{
                knightSquares = knightSquares21;
              }
            }
          } break;
          default: knightSquares = knightSquares1;
        }
        for(var x =0; x < knightSquares.length; x++) {
          var tempNo2 = number + knightSquares[x];
          if(0<= tempNo2 && tempNo2 <=63) {
            if(!list_of_whites.contains(list_of_pieces[array4[tempNo2]] )) {
              if(list_of_blacks.contains(list_of_pieces[array4[tempNo2]] )) {
                var z = array4[tempNo2];
                array4[tempNo2] = 7;
                array4[number] = 12;
                if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
                  legalMovesList.add(tempNo2);
                  borders[tempNo2] = legalMoveBorder;
                }
                array4[number] = 7;
                array4[tempNo2] = z;
                continue;
              }
              // var z = array4[tempNo2];        
              array4[tempNo2] = 7;
              array4[number] = 12;
              if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
                legalMovesList.add(tempNo2);
                borders[tempNo2] = legalMoveBorder;
                array4[tempNo2] = legalMoveBox;
              }
              array4[tempNo2] = 12;
              array4[number] = 7;
            }
          }
        }
  } //wNcase end

  void wPcase (number) {
    var tempNo1 = number;
        if( !list_of_whites.contains(list_of_pieces[array4[tempNo1 -8]] ) && !list_of_blacks.contains(list_of_pieces[array4[tempNo1 -8]] )) {          
          array4[tempNo1 -8] = 11;
          array4[number] = 12;
          if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
            legalMovesList.add(tempNo1 -8);
            borders[tempNo1 -8] = legalMoveBorder;
          }
          array4[number] = 11;
          array4[tempNo1 -8] = 12;
          if(number - number%8 == 48) {
            if( !list_of_whites.contains(list_of_pieces[array4[tempNo1 -16]] ) && !list_of_blacks.contains(list_of_pieces[array4[tempNo1 -16]] )) {
              array4[tempNo1 -16] = 11;
              array4[number] = 12;
              if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
                legalMovesList.add(tempNo1 -16);
                borders[tempNo1 -16] = legalMoveBorder;                
              }
              array4[number] = 11;
              array4[tempNo1 -16] = 12;
            }
          }
        }
        if (list_of_blacks.contains(list_of_pieces[array4[tempNo1 -7]] )) {
          //ATTACKING BLACK PIECE
          var z = array4[tempNo1 -7];
          array4[tempNo1 -7] = 11;
          array4[number] = 12;
          if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
            legalMovesList.add(tempNo1 -7);
            borders[tempNo1 -7] = legalMoveBorder;
          }
          array4[number] = 11;
          array4[tempNo1 -7] = z;
        }
        if (list_of_blacks.contains(list_of_pieces[array4[tempNo1 -9]] )) {
          //ATTACKING BLACK PIECE
          var z = array4[tempNo1 -9];
          array4[tempNo1 -9] = 11;
          array4[number] = 12;
          if(!reverse_check_finder_for_wK(array4.indexOf(10))) {
            legalMovesList.add(tempNo1 -9);
            borders[tempNo1 -9] = legalMoveBorder;
          }
          array4[number] = 11;
          array4[tempNo1 -9] = z;
        }
  } //wPcase end

  List caseK (number) {
    var tempNo1 = number;
        var kingSquares;
        var kingSquares1 = [8, 7, -1, -9, -8, -7, 1, 9];
        var kingSquares2 = [1, 8, 9];
        var kingSquares3 = [-8, -7, 1];
        var kingSquares4 = [-8, -7, 1, 9, 8];
        var kingSquares5 = [-1, 7, 8];
        var kingSquares6 = [-1, -9, -8];
        var kingSquares7 = [-1, -9, -8, 8, 7];
        switch (number%8) {
          case 0:{
            switch (number - number%8) {
              case 0:{
                kingSquares = kingSquares2;
              } break;
              case 56:{
                kingSquares = kingSquares3;
              } break;
              default : {
                kingSquares = kingSquares4;
              }
            }
          } break;
          case 7:{
            switch (number - number%8) {
              case 0:{
                kingSquares = kingSquares5;
              } break;
              case 56:{
                kingSquares = kingSquares6;
              } break;
              default :{
                kingSquares = kingSquares7;
              }
            }
          } break;
          default: kingSquares = kingSquares1;
        }
    return kingSquares;
  } //caseK end

  void bRcase (number) {
    var tempNo1 = number;
        for (tempNo1= number + 1; tempNo1 < (number - (number%8) +8 ) ; tempNo1++) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }
          var zz = array4[number];//this additon is for the illegal move prevention
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[number] = zz;     
          array4[tempNo1] = 12;
        }
        for (tempNo1= number - 1; tempNo1 >= (number - (number%8) ) ; tempNo1--) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }
          var zz = array4[number];
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[number] = zz;     
          array4[tempNo1] = 12;
        }
        for (tempNo1= number - 8; tempNo1 >= (number%8) ; tempNo1-=8) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }
          var zz = array4[number];
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[number] = zz;     
          array4[tempNo1] = 12;
        }
        for (tempNo1= number + 8; tempNo1 <= 56+(number%8) ; tempNo1+=8) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            var z = array4[tempNo1];
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;
            }
            array4[number] = zz;
            array4[tempNo1] = z;
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            break;
          }
          var zz = array4[number];
          array4[tempNo1] = zz;
          array4[number] = 12;
          if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
            legalMovesList.add(tempNo1);
            borders[tempNo1] = legalMoveBorder;
          }
          array4[number] = zz;     
          array4[tempNo1] = 12;
        }
  } //bRcase end

  void bBcase (number) {
    var tempNo1 = number;
        if(!list_of_east_border.contains(number)) {
          for (tempNo1= number -7; ; tempNo1-=7) {
            if(tempNo1 < 0) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;  
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_east_border.contains(number)) {
          for (tempNo1= number +9; ; tempNo1+=9) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;  
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number +7; ; tempNo1+=7) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;  
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number -9; ; tempNo1-=9) {
            if(tempNo1 <0) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              var z = array4[tempNo1];
              var zz = array4[number];
              array4[tempNo1] = zz;
              array4[number] = 12;
              if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
                legalMovesList.add(tempNo1);
                borders[tempNo1] = legalMoveBorder;
              }
              array4[number] = zz;
              array4[tempNo1] = z;
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              break;
            }
            var zz = array4[number];
            array4[tempNo1] = zz;
            array4[number] = 12;
            if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
              legalMovesList.add(tempNo1);
              borders[tempNo1] = legalMoveBorder;  
            }
            array4[tempNo1] = 12;
            array4[number] = zz;
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
  } //bBcase end

  void bNcase (number) {
    var tempNo1 = number;
        var knightSquares;
        var knightSquares1 = [-10, -17, -15, -6, 10, 17, 15, 6];
        var knightSquares2 = [17, 10];
        var knightSquares3 = [-6, 10, 17];
        var knightSquares4 = [-15, -6, 10];
        var knightSquares5 = [-15, -6];
        var knightSquares6 = [-15, -6, 10, 17];
        var knightSquares7 = [17, 10, 15];
        var knightSquares8 = [17, 10, 15, -6];
        var knightSquares9 = [10, -6, -15, -17];
        var knightSquares10 = [-6, -15, -17];
        var knightSquares11 = [10, -6, -15, -17, 17, 15];
        var knightSquares12 = [6, 15, 17];
        var knightSquares13 = [6, 15, 17, -10];
        var knightSquares14 = [6, -10, -15, -17];
        var knightSquares15 = [-10, -17, -15];
        var knightSquares16 = [6, -10, -17, -15, 17, 15];
        var knightSquares17 = [6, 15];
        var knightSquares18 = [-10, 6, 15];
        var knightSquares19 = [6, -10, -17];
        var knightSquares20 = [-10, -17];
        var knightSquares21 = [15, 6, -10, -17];
        switch (number%8) {
          case 0:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares2;
              } break;
              case 8:{
                knightSquares = knightSquares3;
              } break;
              case 48:{
                knightSquares = knightSquares4;
              } break;
              case 56:{
                knightSquares = knightSquares5;
              } break;
              default : {
                knightSquares = knightSquares6;
              }
            }
          } break;
          case 1:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares7;
              } break;
              case 8:{
                knightSquares = knightSquares8;
              } break;
              case 48:{
                knightSquares = knightSquares9;
              } break;
              case 56:{
                knightSquares = knightSquares10;
              } break;
              default :{
                knightSquares = knightSquares11;
              }
            }
          } break;
          case 6:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares12;
              } break;
              case 8:{
                knightSquares = knightSquares13;
              } break;
              case 48:{
                knightSquares = knightSquares14;
              } break;
              case 56:{
                knightSquares = knightSquares15;
              } break;
              default : {
                knightSquares = knightSquares16;
              }
            }
          } break;
          case 7:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares17;
              } break;
              case 8:{
                knightSquares = knightSquares18;
              } break;
              case 48:{
                knightSquares = knightSquares19;
              } break;
              case 56:{
                knightSquares = knightSquares20;
              } break;
              default :{
                knightSquares = knightSquares21;
              }
            }
          } break;
          default: knightSquares = knightSquares1;
        }
        for(var x =0; x < knightSquares.length; x++) {
          var tempNo2 = number + knightSquares[x];
          if(0<= tempNo2 && tempNo2 <=63) {
            if(!list_of_blacks.contains(list_of_pieces[array4[tempNo2]] )) {
              if(list_of_whites.contains(list_of_pieces[array4[tempNo2]] )) {
                var z = array4[tempNo2];
                array4[tempNo2] = 1;
                array4[number] = 12;
                if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
                  legalMovesList.add(tempNo2);
                  borders[tempNo2] = legalMoveBorder;
                }
                array4[number] = 1;
                array4[tempNo2] = z;
                continue;
              }
              array4[tempNo2] = 1;
              array4[number] = 12;
              if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
                legalMovesList.add(tempNo2);
                borders[tempNo2] = legalMoveBorder;
                array4[tempNo2] = legalMoveBox;
              }
              array4[tempNo2] = 12;
              array4[number] = 1;
            }
          }
        }
  } //bNcase end

  void bPcase (number) {
    var tempNo1 = number;
        if( !list_of_whites.contains(list_of_pieces[array4[tempNo1 +8]] ) && !list_of_blacks.contains(list_of_pieces[array4[tempNo1 +8]] )) {
          array4[tempNo1 +8] = 5;
          array4[number] = 12;
          if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
            legalMovesList.add(tempNo1 +8);
            borders[tempNo1 +8] = legalMoveBorder;
          }
          array4[number] = 5;
          array4[tempNo1 +8] = 12;
          if(number - number%8 == 8) {
            if( !list_of_whites.contains(list_of_pieces[array4[tempNo1 +16]] ) && !list_of_blacks.contains(list_of_pieces[array4[tempNo1 +16]] )) {
              array4[tempNo1 +16] = 5;
              array4[number] = 12;
              if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
                legalMovesList.add(tempNo1 +16);
                borders[tempNo1 +16] = legalMoveBorder;                
              }
              array4[number] = 5;
              array4[tempNo1 +16] = 12;
            }
          }
        }
        if (list_of_whites.contains(list_of_pieces[array4[tempNo1 +7]] )) {
          //ATTACKING White PIECE
          var z = array4[tempNo1 +7];
          array4[tempNo1 +7] = 5;
          array4[number] = 12;
          if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
            legalMovesList.add(tempNo1 +7);
            borders[tempNo1 +7] = legalMoveBorder;
          }
          array4[number] = 5;
          array4[tempNo1 +7] = z;
        }
        if (list_of_whites.contains(list_of_pieces[array4[tempNo1 +9]] )) {
          //ATTACKING White PIECE
          var z = array4[tempNo1 +9];
          array4[tempNo1 +9] = 5;
          array4[number] = 12;
          if(!reverse_check_finder_for_bK(array4.indexOf(4))) {
            legalMovesList.add(tempNo1 +9);
            borders[tempNo1 +9] = legalMoveBorder;
          }
          array4[number] = 5;
          array4[tempNo1 +9] = z;
        }
  } //bPcase end
  //pieces end

  bool reverse_check_finder_for_bK(number) {
    // var number = array4.indexOf(4);
    bool isCheck = false;

    //Knight check
        var tempNo1 = number;
        var knightSquares;
        var knightSquares1 = [-10, -17, -15, -6, 10, 17, 15, 6];
        var knightSquares2 = [17, 10];
        var knightSquares3 = [-6, 10, 17];
        var knightSquares4 = [-15, -6, 10];
        var knightSquares5 = [-15, -6];
        var knightSquares6 = [-15, -6, 10, 17];
        var knightSquares7 = [17, 10, 15];
        var knightSquares8 = [17, 10, 15, -6];
        var knightSquares9 = [10, -6, -15, -17];
        var knightSquares10 = [-6, -15, -17];
        var knightSquares11 = [10, -6, -15, -17, 17, 15];
        var knightSquares12 = [6, 15, 17];
        var knightSquares13 = [6, 15, 17, -10];
        var knightSquares14 = [6, -10, -15, -17];
        var knightSquares15 = [-6, -17, -15];
        var knightSquares16 = [6, -10, -17, -15, 17, 15];
        var knightSquares17 = [6, 15];
        var knightSquares18 = [-10, 6, 15];
        var knightSquares19 = [6, -10, -17];
        var knightSquares20 = [-10, -17];
        var knightSquares21 = [15, 6, -10, -17];
        switch (number%8) {
          case 0:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares2;
              } break;
              case 8:{
                knightSquares = knightSquares3;
              } break;
              case 48:{
                knightSquares = knightSquares4;
              } break;
              case 56:{
                knightSquares = knightSquares5;
              } break;
              default : {
                knightSquares = knightSquares6;
              }
            }
          } break;
          case 1:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares7;
              } break;
              case 8:{
                knightSquares = knightSquares8;
              } break;
              case 48:{
                knightSquares = knightSquares9;
              } break;
              case 56:{
                knightSquares = knightSquares10;
              } break;
              default :{
                knightSquares = knightSquares11;
              }
            }
          } break;
          case 6:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares12;
              } break;
              case 8:{
                knightSquares = knightSquares13;
              } break;
              case 48:{
                knightSquares = knightSquares14;
              } break;
              case 56:{
                knightSquares = knightSquares15;
              } break;
              default : {
                knightSquares = knightSquares16;
              }
            }
          } break;
          case 7:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares17;
              } break;
              case 8:{
                knightSquares = knightSquares18;
              } break;
              case 48:{
                knightSquares = knightSquares19;
              } break;
              case 56:{
                knightSquares = knightSquares20;
              } break;
              default :{
                knightSquares = knightSquares21;
              }
            }
          } break;
          default: knightSquares = knightSquares1;
        }
        for(var x =0; x < knightSquares.length; x++) {
          var tempNo2 = number + knightSquares[x];
          if(0<= tempNo2 && tempNo2 <=63) {
            if(array4[tempNo2] == 7) {
              print('Check');
              isCheck = true;
            }
          }
        }
    //knight check end
    //queen and others check start
        tempNo1 = number;
        
        for (tempNo1= number + 1; tempNo1 < (number - (number%8) +8 ) ; tempNo1++) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 4) {
              continue;
            }
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==6 || array4[tempNo1]==9){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        for (tempNo1= number - 1; tempNo1 >= (number - (number%8) ) ; tempNo1--) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 4) {
              continue;
            }
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==6 || array4[tempNo1]==9){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        for (tempNo1= number - 8; tempNo1 >= (number%8) ; tempNo1-=8) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 4) {
              continue;
            }
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==6 || array4[tempNo1]==9){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        for (tempNo1= number + 8; tempNo1 <= 56+(number%8) ; tempNo1+=8) {
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 4) {
              continue;
            }
            break;
          }
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==6 || array4[tempNo1]==9){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        //Bishop part
        if(!list_of_east_border.contains(number)) {
          for (tempNo1= number -7; ; tempNo1-=7) {
            if(tempNo1 < 0) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 4) {
                continue;
              }
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==8 ||array4[tempNo1]==9){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_east_border.contains(number)) {
          for (tempNo1= number +9; ; tempNo1+=9) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 4) {
                continue;
              }
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==8 ||array4[tempNo1]==9){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number +7; ; tempNo1+=7) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 4) {
                continue;
              }
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==8 ||array4[tempNo1]==9){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number -9; ; tempNo1-=9) {
            if(tempNo1 <0) {
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 4) {
                continue;
              }
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==8 ||array4[tempNo1]==9){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        
    //queen and others check end
    //pawns check
    if(list_of_east_border.contains(number)) {
      if(array4[number+7] == 11) {
        print('Check');
        isCheck = true;
      }
    }
    else if (list_of_west_border.contains(number)) {
      if(array4[number+9] == 11) {
        print('Check');
        isCheck = true;
      }
    }
    else if ((array4[number+7] == 11) || (array4[number+9] == 11)) {
      print('Check');
      isCheck = true;
    }
  
  return isCheck;
  }//bK check end

  bool reverse_check_finder_for_wK(number) {
      // var number = array4.indexOf(28);
    bool isCheck = false;

    //Knight check
        var tempNo1 = number;
        var knightSquares;
        var knightSquares1 = [-10, -17, -15, -6, 10, 17, 15, 6];
        var knightSquares2 = [17, 10];
        var knightSquares3 = [-6, 10, 17];
        var knightSquares4 = [-15, -6, 10];
        var knightSquares5 = [-15, -6];
        var knightSquares6 = [-15, -6, 10, 17];
        var knightSquares7 = [17, 10, 15];
        var knightSquares8 = [17, 10, 15, -6];
        var knightSquares9 = [10, -6, -15, -17];
        var knightSquares10 = [-6, -15, -17];
        var knightSquares11 = [10, -6, -15, -17, 17, 15];
        var knightSquares12 = [6, 15, 17];
        var knightSquares13 = [6, 15, 17, -10];
        var knightSquares14 = [6, -10, -15, -17];
        var knightSquares15 = [-6, -17, -15];
        var knightSquares16 = [6, -10, -17, -15, 17, 15];
        var knightSquares17 = [6, 15];
        var knightSquares18 = [-10, 6, 15];
        var knightSquares19 = [6, -10, -17];
        var knightSquares20 = [-10, -17];
        var knightSquares21 = [15, 6, -10, -17];
        switch (number%8) {
          case 0:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares2;
              } break;
              case 8:{
                knightSquares = knightSquares3;
              } break;
              case 48:{
                knightSquares = knightSquares4;
              } break;
              case 56:{
                knightSquares = knightSquares5;
              } break;
              default : {
                knightSquares = knightSquares6;
              }
            }
          } break;
          case 1:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares7;
              } break;
              case 8:{
                knightSquares = knightSquares8;
              } break;
              case 48:{
                knightSquares = knightSquares9;
              } break;
              case 56:{
                knightSquares = knightSquares10;
              } break;
              default :{
                knightSquares = knightSquares11;
              }
            }
          } break;
          case 6:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares12;
              } break;
              case 8:{
                knightSquares = knightSquares13;
              } break;
              case 48:{
                knightSquares = knightSquares14;
              } break;
              case 56:{
                knightSquares = knightSquares15;
              } break;
              default : {
                knightSquares = knightSquares16;
              }
            }
          } break;
          case 7:{
            switch (number - number%8) {
              case 0:{
                knightSquares = knightSquares17;
              } break;
              case 8:{
                knightSquares = knightSquares18;
              } break;
              case 48:{
                knightSquares = knightSquares19;
              } break;
              case 56:{
                knightSquares = knightSquares20;
              } break;
              default :{
                knightSquares = knightSquares21;
              }
            }
          } break;
          default: knightSquares = knightSquares1;
        }
        for(var x =0; x < knightSquares.length; x++) {
          var tempNo2 = number + knightSquares[x];
          if(0<= tempNo2 && tempNo2 <=63) {
            if(array4[tempNo2] == 1) {
              print('Check');
              isCheck = true;
            }
          }
        }
    //knight check end
    //queen and others check
    tempNo1 = number;
        for (tempNo1= number + 1; tempNo1 < (number - (number%8) +8 ) ; tempNo1++) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 10) {
              continue;
            }
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==0 || array4[tempNo1]==3){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        for (tempNo1= number - 1; tempNo1 >= (number - (number%8) ) ; tempNo1--) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 10) {
              continue;
            }
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==0 || array4[tempNo1]==3){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        for (tempNo1= number - 8; tempNo1 >= (number%8) ; tempNo1-=8) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 10) {
              continue;
            }
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==0 || array4[tempNo1]==3){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        for (tempNo1= number + 8; tempNo1 <= 56+(number%8) ; tempNo1+=8) {
          if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1] == 10) {
              continue;
            }
            break;
          }
          if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
            if(array4[tempNo1]==0 || array4[tempNo1]==3){
              print('Check');
              isCheck = true;
              break;
            }
            break;
          }
        }
        //Bishop part
        if(!list_of_east_border.contains(number)) {
          for (tempNo1= number -7; ; tempNo1-=7) {
            if(tempNo1 < 0) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 10) {
                continue;
              }
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==2 || array4[tempNo1]==3){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_east_border.contains(number)) {
          for (tempNo1= number +9; ; tempNo1+=9) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 10) {
                continue;
              }
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==2 || array4[tempNo1]==3){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number +7; ; tempNo1+=7) {
            if(tempNo1 > 63) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 10) {
                continue;
              }
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==2 || array4[tempNo1]==3){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
        if(!list_of_west_border.contains(number)) {
          for (tempNo1= number -9; ; tempNo1-=9) {
            if(tempNo1 <0) {
              break;
            }
            if(list_of_whites.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1] == 10) {
                continue;
              }
              break;
            }
            if(list_of_blacks.contains(list_of_pieces[array4[tempNo1]] )){
              if(array4[tempNo1]==2 || array4[tempNo1]==3){
                print('Check');
                isCheck = true;
                break;
              }
              break;
            }
            if(list_of_borders.contains(tempNo1)){
              break;
            }
          }
        }
    //queen and others check end
    //pawns check
    if(list_of_east_border.contains(number)) {
      if(array4[number-9] == 5) {
        print('Check');
        isCheck = true;
      }
    }
    else if (list_of_west_border.contains(number)) {
      if(array4[number-7] == 5) {
        print('Check');
        isCheck = true;
      }
    }
    else if ((array4[number-7] == 5) || (array4[number-9] == 5)) {
      print('Check');
      isCheck = true;
    }
  
  return isCheck;
  } //rev white end

  //castling part
  bool castlingAllowedForWhite = true;
  bool castlingAllowedKingSideForWhite = true;
  bool castlingAllowedQueenSideForWhite = true;

  bool castlingAllowedForBlack = true;
  bool castlingAllowedKingSideForBlack = true;
  bool castlingAllowedQueenSideForBlack = true;

  void castleWhite () {
          if(castlingAllowedForWhite) {
            if(castlingAllowedKingSideForWhite) {
              if(array4[62] == 10) {
                array4[61] = 6;
                array4[63] = 12;
                castlingAllowedKingSideForWhite = false;
              }
              else if(array4[63] != 6) {
                castlingAllowedKingSideForWhite = false;
              }
            }
            if(castlingAllowedQueenSideForWhite) {
              if(array4[58] == 10) {
                array4[59] = 6;
                array4[56] = 12;
                castlingAllowedQueenSideForWhite = false;
              }
              else if(array4[56] != 6) {
                castlingAllowedQueenSideForWhite = false;
              }
            }
            if(array4[60] != 10) {
              castlingAllowedForWhite = false;
            }
          }
  }

  void castleBlack ()
  {
          if(castlingAllowedForBlack) {
            if(castlingAllowedKingSideForBlack) {
              if(array4[6] == 4) {
                array4[5] = 0;
                array4[7] = 12;
                castlingAllowedKingSideForBlack = false;
              }
              else if(array4[7] != 0) {
                castlingAllowedKingSideForBlack = false;
              }
            }
            if(castlingAllowedQueenSideForBlack) {
              if(array4[2] == 4) {
                array4[3] = 0;
                array4[0] = 12;
                castlingAllowedQueenSideForBlack = false;
              }
              else if(array4[0] != 0) {
                castlingAllowedQueenSideForBlack = false;
              }
            }
            if(array4[4] != 4) {
              castlingAllowedForBlack = false;
            }
          }
  }
  
  void reset () {
    text2 = 0;
    turn_counter = 0;
    move_displayer = 0;
    pieceCounter1 = 0;
    pieceCounter2 = 0;
    legalMoveBox = 12;//emptyBox;
    callFlushbar = false;
    castlingAllowedForWhite = true;
    castlingAllowedKingSideForWhite = true;
    castlingAllowedQueenSideForWhite = true;
    castlingAllowedForBlack = true;
    castlingAllowedKingSideForBlack = true;
    castlingAllowedQueenSideForBlack = true;
    for(var x=0; x<64; x++) {
      borders[x] = null;
    }
    borders[63] = Border.all(width: 0, color: Colors.red);
    array4[0] = 0; array4[1] = 1; array4[2] = 2; array4[3] = 3; array4[4] = 4; array4[5] = 2; array4[6] = 1; array4[7] = 0;
    array4[8] = 5; array4[9] = 5; array4[10] = 5; array4[11] = 5; array4[12] = 5; array4[13] = 5; array4[14] = 5; array4[15] = 5; 
    array4[16] = 12; array4[17] = 12; array4[18] = 12; array4[19] = 12; array4[20] = 12; array4[21] = 12; array4[22] = 12; array4[23] = 12; 
    array4[24] = 12; array4[25] = 12; array4[26] = 12; array4[27] = 12; array4[28] = 12; array4[29] = 12; array4[30] = 12; array4[31] = 12; 
    array4[32] = 12; array4[33] = 12; array4[34] = 12; array4[35] = 12; array4[36] = 12; array4[37] = 12; array4[38] = 12; array4[39] = 12; 
    array4[40] = 12; array4[41] = 12; array4[42] = 12; array4[43] = 12; array4[44] = 12; array4[45] = 12; array4[46] = 12; array4[47] = 12; 
    array4[48] = 11; array4[49] = 11; array4[50] = 11; array4[51] = 11; array4[52] = 11; array4[53] = 11; array4[54] = 11; array4[55] = 11; 
    array4[56] = 6; array4[57] = 7; array4[58] = 8; array4[59] = 9; array4[60] = 10; array4[61] = 8; array4[62] = 7; array4[63] = 6;
  }

  final ch = Flushbar(
    title: '',
    messageText: Text('Check', style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center,),
    duration: Duration(seconds: 1),
  );

  final c = SnackBar(
    content: Text('Check'),
    duration: Duration(milliseconds: 1500),
  );

  final sn = SnackBar(
                  content: Row(
                    children: <Widget>[
                      InkWell(
                        child: Text('data\t'),
                        onTap: () {
                          print('object');
                        },
                      ),
                      InkWell(
                        child: Text('data2\t'),
                        onTap: () {
                          print('object2');
                        },
                      ),
                      InkWell(
                        child: Text('data3\t'),
                        onTap: () {
                          print('object3');
                        },
                      ),
                    ],
                  ),//Text('Profile Save'),
                  duration: Duration(seconds: 20),
                );

  //animatedopacity
  // double opacityLevel = 1.0;

  // void _changeOpacity() {
  //   setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  // }

  //The Stuff
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chess',
      home: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Chessed Out"),
            backgroundColor: Colors.black,
            actions: <Widget>[
              Row(
                children: <Widget>[
                  Text('No. of taps: '),
                  Text('$text2', style: TextStyle(fontSize: 50),),
                ],
              ),
              //Text(legalMovesList[0]),
            ],
          ),
          body: Center(
            child: Builder(
              builder: (context) => Column(
              //crossAxisCount: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, //From when this was a column //i don't remember how old but it's a col now
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Tab(child: Image(image: AssetImage('assets/bK-icon.png')),),
                    // Text("♚", style: TextStyle(fontSize: 60),),
                    Text("vs", style: TextStyle(fontSize: 40, color: Colors.black45),),
                    // Text("♔", style: TextStyle(fontSize: 60),),
                    Tab(child: Image(image: AssetImage('assets/wK-icon.png')),)
                  ],
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(
                    child: Container(
                      child: GridView.count(
                        //padding: EdgeInsets.all(10),
                        crossAxisCount: 8,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[0], color: Colors.white),
                              child: Center(child: list_of_pieces[array4[0]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(0);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[1], color: Colors.black),
                              child: Center(child: list_of_pieces[array4[1]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(1);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[2], color: Colors.white),
                              child: Center(child: list_of_pieces[array4[2]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(2);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[3], color: Colors.black),
                              child: Center(child: list_of_pieces[array4[3]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(3);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[4], color: Colors.white),
                              child: Center(child: list_of_pieces[array4[4]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(4);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[5], color: Colors.black),
                              child: Center(child:list_of_pieces[array4[5]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(5);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[6], color: Colors.white),
                              child: Center(child:list_of_pieces[array4[6]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(6);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[7], color: Colors.black),
                              child: Center(child:list_of_pieces[array4[7]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(7);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: wQ, onTap: () {setState(() {
                                          array4[promoNo] = 9; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wR, onTap: () {setState(() {
                                          array4[promoNo] = 6; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wB, onTap: () {setState(() {
                                          array4[promoNo] = 8; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                        InkWell(child: wN, onTap: () {setState(() {
                                          array4[promoNo] = 7; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_bK(array4.indexOf(4))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[8], color: Colors.black),
                              child: Center(child:list_of_pieces[array4[8]],),                              
                            ),
                            onTap: () {
                              setState(() {
                                movement(8);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[9]],),
                              decoration: BoxDecoration(border: borders[9], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(9);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[10]],),
                              decoration: BoxDecoration(border: borders[10], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(10);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[11]],),
                              decoration: BoxDecoration(border: borders[11], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(11);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[12]],),
                              decoration: BoxDecoration(border: borders[12], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(12);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[13]],),
                              decoration: BoxDecoration(border: borders[13], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(13);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[14]],),
                              decoration: BoxDecoration(border: borders[14], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(14);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[15]],),
                              decoration: BoxDecoration(border: borders[15], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(15);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[16]],),
                              decoration: BoxDecoration(border: borders[16], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(16);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[17]],),
                              decoration: BoxDecoration(border: borders[17], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(17);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[18]],),
                              decoration: BoxDecoration(border: borders[18], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(18);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[19]],),
                              decoration: BoxDecoration(border: borders[19], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(19);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[20]],),
                              decoration: BoxDecoration(border: borders[20], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(20);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[21]],),
                              decoration: BoxDecoration(border: borders[21], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(21);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[22]],),
                              decoration: BoxDecoration(border: borders[22], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(22);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[23]],),
                              decoration: BoxDecoration(border: borders[23], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(23);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[24]],),
                              decoration: BoxDecoration(border: borders[24], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(24);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[25]],),
                              decoration: BoxDecoration(border: borders[25], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(25);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[26]],),
                              decoration: BoxDecoration(border: borders[26], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(26);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[27]],),
                              decoration: BoxDecoration(border: borders[27], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(27);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[28]],),
                              decoration: BoxDecoration(border: borders[28], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(28);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[29]],),
                              decoration: BoxDecoration(border: borders[29], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(29);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[30]],),
                              decoration: BoxDecoration(border: borders[30], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(30);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[31]],),
                              decoration: BoxDecoration(border: borders[31], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(31);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[32]],),
                              decoration: BoxDecoration(border: borders[32], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(32);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[33]],),
                              decoration: BoxDecoration(border: borders[33], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(33);
                              });
                            },
                          ),
                          ////////////////////////////////////////WORK-IN-PROGRESS//////////////////////////////////////
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(border: borders[34], color: Colors.white),
                              child: Center(child:list_of_pieces[array4[34]],),
                              //color: zz//Colors.white,
                            ),
                            onTap: () {
                              setState(() {
                                //legal_moves_displayer(34);
                                movement(34);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[35]],),
                              decoration: BoxDecoration(border: borders[35], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(35);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[36]],),
                              decoration: BoxDecoration(border: borders[36], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(36);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[37]],),
                              decoration: BoxDecoration(border: borders[37], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(37);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[38]],),
                              decoration: BoxDecoration(border: borders[38], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(38);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[39]],),
                              decoration: BoxDecoration(border: borders[39], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(39);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[40]],),
                              decoration: BoxDecoration(border: borders[40], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(40);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[41]],),
                              decoration: BoxDecoration(border: borders[41], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(41);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[42]],),
                              decoration: BoxDecoration(border: borders[42], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(42);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[43]],),
                              decoration: BoxDecoration(border: borders[43], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(43);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[44]],),
                              decoration: BoxDecoration(border: borders[44], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(44);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[45]],),
                              decoration: BoxDecoration(border: borders[45], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(45);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[46]],),
                              decoration: BoxDecoration(border: borders[46], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(46);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[47]],),
                              decoration: BoxDecoration(border: borders[47], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(47);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[48]],),
                              decoration: BoxDecoration(border: borders[48], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(48);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[49]],),
                              decoration: BoxDecoration(border: borders[49], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(49);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[50]],),
                              decoration: BoxDecoration(border: borders[50], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(50);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[51]],),
                              decoration: BoxDecoration(border: borders[51], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(51);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[52]],),
                              decoration: BoxDecoration(border: borders[52], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(52);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[53]],),
                              decoration: BoxDecoration(border: borders[53], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(53);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[54]],),
                              decoration: BoxDecoration(border: borders[54], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(54);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[55]],),
                              decoration: BoxDecoration(border: borders[55], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(55);
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[56]],),
                              decoration: BoxDecoration(border: borders[56], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(56);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[57]],),
                              decoration: BoxDecoration(border: borders[57], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(57);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[58]],),
                              decoration: BoxDecoration(border: borders[58], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(58);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[59]],),
                              decoration: BoxDecoration(border: borders[59], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(59);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[60]],),
                              decoration: BoxDecoration(border: borders[60], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(60);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[61]],),
                              decoration: BoxDecoration(border: borders[61], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(61);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[62]],),
                              decoration: BoxDecoration(border: borders[62], color: Colors.black),
                            ),
                            onTap: () {
                              setState(() {
                                movement(62);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Center(child:list_of_pieces[array4[63]],),
                              decoration: BoxDecoration(border: borders[63], color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                movement(63);
                                if(callFlushbar) {
                                  Flushbar(
                                    barBlur: 1, blockBackgroundInteraction: false,
                                    titleText: Text('Pawn Promotion\n', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                    messageText: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[    
                                        InkWell(child: bQ, onTap: () {setState(() {
                                          array4[promoNo] = 3; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bR, onTap: () {setState(() {
                                          array4[promoNo] = 0; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bB, onTap: () {setState(() {
                                          array4[promoNo] = 2; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                        InkWell(child: bN, onTap: () {setState(() {
                                          array4[promoNo] = 1; callFlushbar = false; Navigator.of(context).pop();
                                          if(reverse_check_finder_for_wK(array4.indexOf(10))) {ch.show(context);}});},),
                                      ],
                                    ),).show(context);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                //Stuff from expriments
                // Text('B $attackBoxListOfBlack', style: TextStyle(fontSize: 20, color: Colors.red),),
                // Text('W $attackBoxListOfWhite', style: TextStyle(fontSize: 20, color: Colors.blue),),
                // Text('TC $turn_counter', style: TextStyle(fontSize: 20, color: Colors.white),),
                // Text('MD $move_displayer', style: TextStyle(fontSize: 20, color: Colors.white),),
                // Text('$legalMovesList', style: TextStyle(color: Colors.white),),
                //Text('PC1 $pieceCounter1', style: TextStyle(fontSize: 20, color: Colors.white),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.black12,
                      child: Text('Reset', style: TextStyle(fontSize: 20, color: Colors.grey),),
                      onPressed: () {
                      setState(() {
                        Flushbar(
                          titleText: Text('Are you sure you wanna RESET ?', style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center,),
                          messageText: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.black12,
                                child: Text('YES', style: TextStyle(fontSize: 20, color: Colors.white)),
                                onPressed: () {
                                  setState(() {
                                    reset();
                                    Navigator.of(context).pop();
                                  });
                                }
                              ),
                              RaisedButton(
                                color: Colors.black12,
                                child: Text('NO', style: TextStyle(fontSize: 20, color: Colors.white)),
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                }
                              )
                            ],
                          ),
                        ).show(context);
                      });
                    }),
                  ]
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}