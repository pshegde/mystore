$(document).ready(function() {
  $(".add").click(function() {
    //event.preventDefault();
    alert("adding to cart!" );
    var a = $(this).attr('name');
    alert(a);
    //$('#current_item').css({'background-color':'#88ff88'}).animate({'background-color':'#114411'}, 1000)
    var request = $.ajax({url: "/catalog/add_to_cart?id=" +a,
           type: "POST"
    });
    //data: JSON.stringify({'id' : a}),

    request.done(function( msg ) {
     /* $('#cart').html("<%=j render @cart %>");*/
      /*$('#current_item').css({'background-color':'#88ff88'}).animate({'background-color':'#114411'}, 1000);*/
        //alert( msg );
    });
     
    request.fail(function( jqXHR, textStatus ) {
        alert( "Request failed: " + textStatus );
        });
  });
});
