
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          //this will create instances of the Deck class and the Notifying class
          Provider(create: (context) => Deck()),
          ChangeNotifierProvider(
            create: (context) => NotifyingHand(),
        ),
      ],
      child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Pick a Card')),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                            DrawCardButton(),
                            PlayingCardList(),
                           ],
        ),
       ),

    );

  }
}

// ignore: must_be_immutable
class PlayingCardCard extends StatelessWidget{
  PlayingCard myCard;
  String rank;
  String suit;

  //constructor
  PlayingCardCard(PlayingCard inputCard) {
    myCard = inputCard;
    rank = myCard.toStringRank();
    suit = myCard.toStringSuit();
    }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55.0,
      height: 100.0,
      child: Card(
        child: Column(
          children: [
             Image.asset("assets/images/$suit.png",
             height: 60,
             width: 45),

           Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text('$rank',
                style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold),
              ),

            ),
          ],
      ),
      ),
    );

    }
}

class PlayingCardList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<NotifyingHand>(
      builder:(context,handInstance,child) {
        //return _items.isEmpty ? Center(child: Text('Empty')) : ListView.builder(
        //return (handInstance.playersCards == null) ? Center(child: Text('Empty')) : ListView.builder(
        return (handInstance.playersCards == null) ? Center(child: Text('Empty')) : Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: handInstance.playersCards.length,
          itemBuilder: (context, index) {
            return Center(child: (PlayingCardCard(handInstance.playersCards[index])));
            },
        ),
        );
      }
    );
  }
}


// ignore: must_be_immutable
class DrawCardButton extends StatelessWidget{
  PlayingCard myCard;
  Deck myDeck;
  NotifyingHand hand;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(

        padding: const EdgeInsets.all(20),
        color: Colors.deepPurple,
        child: Text('Click to Draw a Card'),

               onPressed: () {
               myDeck = Provider.of<Deck>(context, listen:false);
               //the drawACard method is called from AddToHand
               //myCard = deck.drawACard();
               if (myDeck == null) {
                 print("Arrgghh, no cards left in deck");
               }
               else {
                 hand = Provider.of<NotifyingHand>(context, listen:false);
                 //its ok if hand is null.
                 bool results = hand.addToHand(myDeck);
                 if (results == false)
                   print("No cards left matey");
               }
             }//onPressed
         );
  }

  }//end DrawCardButton

