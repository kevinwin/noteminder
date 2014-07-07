$(document).ready(function(){
  $("#addNewDeck").click(function(){
    $("#deckSet").html($("#new_decks_form").html())
    // $("#deckSet").append($("#new_decks_form").html());
    // $("#addNewDeck").hide();
    // $("#deck_select").hide();
  });
});

