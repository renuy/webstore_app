// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$('.toggle_history').live('click', function() {
	var history_id = this.id.split("_");
	history_id.shift();
	history_id = '#' + history_id.join("_");

	$(history_id).toggle();

	var isShown = ($(history_id).css("display") == "none" ? false : true);

	this.innerHTML = (isShown ? "Hide History" : "Show History");

	if ( isShown ) {
		$(history_id).data('jsp').reinitialise();
	}
});

$('.toggle_stock').live('click', function() {
	var stock_id = this.id.split("_");
	stock_id.shift();
	stock_id = '#' + stock_id.join("_");

	$(stock_id).toggle();

	var isShown = ($(stock_id).css("display") == "none" ? false : true);

	this.innerHTML = (isShown ? "Hide Stock" : "Show Stock");

	if ( isShown ) {
		$(stock_id).data('jsp').reinitialise();
	}
});

var Collectionapp = {};
Collectionapp.TitleData = {};
Collectionapp.shelves = ['div_coll_'];
Collectionapp.kidsData = {};

Collectionapp.showNextPage = function(profile_id, title_id){
//$('#'+div).scrollTo({ top: '+=1000px', left: '+=0px' }, 800);
//$("#"+div+"_frn").hide();
hid_field = "#field_"+profile_id+"_"+title_id;
div_right_back = "#div_"+profile_id+"_"+title_id+"_right";
div_right = "#div_"+profile_id+"_"+title_id+"_right_bck";
page_no = $(hid_field).val();
$(hid_field).val( "_bck");

if (page_no  == '_bck'){
  $(hid_field).val( "");
  div_right_back = "#div_"+profile_id+"_"+title_id+"_right_bck";
  div_right = "#div_"+profile_id+"_"+title_id+"_right";
}
$(div_right_back).animate({ width: '375', opacity:1}, "fast",function(){});
$(div_right_back).animate({"scrollTop": $(div_right_back).scrollTop() + 250},"fast");

$(div_right).animate({ width: '0', opacity:.05}, 600,function(){});
$(div_right).animate({"scrollTop": $(div_right_back).scrollTop() +250},"fast");
}

Collectionapp.showPrevPage = function(profile_id, title_id){
hid_field = "#field_"+profile_id+"_"+title_id;
div_right_back = "#div_"+profile_id+"_"+title_id+"_right";
div_right = "#div_"+profile_id+"_"+title_id+"_right_bck";
page_no = $(hid_field).val();
$(hid_field).val( "_bck");

if (page_no  == '_bck'){
  $(hid_field).val( "");
  div_right_back = "#div_"+profile_id+"_"+title_id+"_right_bck";
  div_right = "#div_"+profile_id+"_"+title_id+"_right";
}
$(div_right_back).animate({ width: '375', opacity:1}, "fast",function(){});
$(div_right_back).animate({"scrollTop": $(div_right_back).scrollTop() - 250},"fast");

$(div_right).animate({ width: '0', opacity:.05}, 600,function(){});
$(div_right).animate({"scrollTop": $(div_right_back).scrollTop() - 250},"fast");
  
}
Collectionapp.showImage = function(image){
  $(image).animate({opacity: 1,
            left: '+=50',
            width: '70%'}, 900,function(){});
}

Collectionapp.stretchImage = function(image){
  $(image).animate({opacity: 1,
            left: '+=50',
            height: '250',
            width: '166'}, 900,function(){});
}
Collectionapp.shrinkImage = function(image){
  $(image).animate({opacity: 1,
            left: '+=50',
            height: '200',
            width: '133'}, 900,function(){});
}

Collectionapp.showShelfContent = function (shelfId, divId) {
  data_id ="infovis"+shelfId;
  collection_count = Collectionapp.TitleData[data_id].length;
  //alert(collection_count);
  if (collection_count > 0){
    var whichtitle1=Math.floor(Math.random()*(collection_count));
    var whichtitle2=Math.floor(Math.random()*(collection_count));
    var whichtitle3=Math.floor(Math.random()*(collection_count));
    $.each(Collectionapp.TitleData[data_id], function(index, value) {
      var id = '#div_' +  shelfId+"_" + value ;
      $(id).hide("fast");
    });

    var divid = '#div_' +  shelfId+"_" + Collectionapp.TitleData[data_id][whichtitle1] ;
    $(divid).animate({opacity: 1,
            left: '+=50',
            height: 'toggle'}, 900,function(){
      divid = '#div_' +  shelfId+"_" + Collectionapp.TitleData[data_id][whichtitle2] ;
      $(divid).animate({opacity: 1,
            left: '+=50',
            height: 'toggle'},900,function(){
        divid = '#div_' +  shelfId+"_" + Collectionapp.TitleData[data_id][whichtitle3] ;
        $(divid).animate({
            opacity: 1,
            left: '+=50',
            height: 'toggle'
          }, 600, function() {
            // Animation complete.
          });
      });
    });
    
  }
	//$('#flash_'+paneId).html('');
};

Collectionapp.toggle_title_div = function () {
$('#bookdetails').toggle();
$('#mybook').toggle();
}

Collectionapp.rollin = function(obj){
img = obj.src;

//img = img.replace('search-normal','search-select');
img='../images/search-select.png'
$('#'+obj.id).attr('src',img);
obj.src=img;

}
Collectionapp.rollout = function(obj){
img = obj.src;
//img = img.replace('search-select','search-normal');
img='../images/search-normal.png'
$('#'+obj.id).attr('src',img);
obj.src=img;

}

Collectionapp.initShelf = function(div_id){
  $('#'+div_id).show('explode', {},1000, function(){});
};

Collectionapp.initSShelf = function(div_id){
$('#'+div_id).show('scale', {},1000, function(){});
};

Collectionapp.changeShelf = function(div_id){
  
  $.each(Collectionapp.kidsData["profile"], function(index, value) {
      var id = '#div_bs_'+ value ;
      $(id).hide("fast");
    });
  $('#div_bs_'+div_id.value).show('fast');
}
Collectionapp.slidepage = function(div_id) {

div_id_hide = $('#curr_div').val();
$('#curr_div').val(div_id);
$('#sel'+div_id_hide).hide('fast',function(){});
$('#sel'+div_id).show('slide',{},600,function(){});
$('#div_ttl_pg'+div_id_hide).hide('fast');
$('#div_ttl_pg'+div_id).show('fast');
};

new_sug = function(div_id){
$('#n_s'+div_id).submit();
}
$('.suggest').live('click', function() {
        $("#dialog_"+$(this).attr('id')).dialog({
          autoOpen: false,
          modal: true,
          width: 280,
          height: 217,
          position: ['center', 'center'],
          overlay: { 
              opacity: 0.7, 
              background: "black" 
          }
        });
        $("#dialog_"+$(this).attr('id')).dialog("open");
    });
$('.rcancel').live('click', function() {
  card_id = $(this).attr('id').replace('can_','');
  $("#dialog_"+card_id).dialog('close');
});
    
$('.renew').live('click', function() {
card_id = $(this).attr('id').replace('link_','');
md = $(this).attr('name')
mon_radio = 'months'+card_id;
months = $('input:radio[name='+mon_radio+']:checked').val();

if (months == null){
  alert('Please select months');
  return false;
 } 
 $("#dialog_"+card_id).dialog('close');
 
 url = '/renewals/new?m='+months+'&md='+md;
 $(location).attr('href',url);
 
 return true;
});