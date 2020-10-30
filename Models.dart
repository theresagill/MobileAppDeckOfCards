import 'package:flutter/material.dart';

class PlayingCard {
  String rank;
  String suit;

  PlayingCard(this.rank, this.suit);

  //toString() {
  //  return '$rank of $suit';
  //}
   String toStringRank() {
    return '$rank';
    }
  String toStringSuit() {
    return '$suit';
  }
}

class Deck {
  List<PlayingCard> cards = []; //List creation and initialization. If not initialized, it is null
  //List is same as array in JAVA. So, saying List<Card> cards essentially means an array of
  //Card objects with the array variable name as cards

  //Constructor.  Takes no parameters
  Deck() {
    var ranks = ['Ace', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Jack', 'Queen', 'King'];
    var suits = ['clubs', 'diamonds', 'hearts', 'spades'];

    for(var suit in suits) {
      for(var rank in ranks) {
        var card = new PlayingCard(rank, suit);
        cards.add(card); //If list not initialized, list becomes null and add() will not work
      }
    }
    shuffle();
  }//end of Deck constructor

  //toString() {
  //  return cards.toString();
  //}

  //Shuffles all cards of the deck randomly
  shuffle() {
    cards.shuffle();
  }

  PlayingCard drawACard() {
    PlayingCard draw;

    if (cards.isEmpty) {
      return null;
    }

    //remove the card from the deck, and place it in draw variable
    draw = cards.removeAt(0);
    return draw;
    }//end drawACard

}//end class Deck


class NotifyingHand extends ChangeNotifier{
  List<PlayingCard> _playersCards = [];//initialize to empty

  //constructor
  NotifyingHand() {
    //_playersCards = null; //initialize to null. Don't do this.  error when adding
  }
  //Get function
  List<PlayingCard> get playersCards{
    return _playersCards;
  }

  //Methods
 bool addToHand(Deck inputDeck) {
    PlayingCard pick;

    pick = inputDeck.drawACard();
    if (pick == null){
      return false;
    }

    _playersCards.add(pick);
    notifyListeners();
    return true;

 }

}//end NotifyingHand

