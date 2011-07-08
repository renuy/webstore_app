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
          height: 230,
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

$('.signup').live('click', function() {
plan_id = $(this).attr('id').replace('link_','');

mon_radio = 'months'+plan_id;
months = $('input:radio[name='+mon_radio+']:checked').val();
branch_id=$('#branch_id').val();
if (months == null){
  alert('Please select months');
  return false;
 } 
 
 url = '/signups/new?m='+months+'&p='+plan_id+'&b='+branch_id;
 $(location).attr('href',url);
 
 return true;
});

$('.quiz').live('click', function() {
 if ($(this).val() == 1) {
    alert('well done!!');
    div_id = $('#curr_div').val();
    Collectionapp.ansImg(div_id);
 }
 else{
  alert('wrong answer, try again');
 }
 

});

Collectionapp.teaseImg = function(id){
  $('#'+id+'img_1').animate({opacity: .20,
            
            }, 900,function(){});
  $('#'+id+'img_2').animate({opacity: .20,
            
            }, 900,function(){});
  $('#'+id+'img_3').animate({opacity: .20,
            
            }, 900,function(){});
  $('#'+id+'img_4').animate({opacity: .20,
            
            }, 900,function(){});
}

Collectionapp.ansImg = function(id){
  $('#'+id+'img_2').hide();
  $('#'+id+'img_3').hide();
  $('#'+id+'img_4').hide();
  $('#'+id+'img_1').animate({opacity: 1,
            height:'200',
            width:'133',
            }, 900,function(){});
}

Collectionapp.quizpage = function(div_id) {
div_id_hide = $('#curr_div').val();
$('#curr_div').val(div_id);
$('#sel'+div_id_hide).hide('fast',function(){});
$('#sel'+div_id).show('slide',{},600,function(){});
$('#div_ttl_pg'+div_id_hide).hide('fast');
$('#div_ttl_pg'+div_id).show('fast');
Collectionapp.teaseImg(div_id);
};


var Sessionapp = {};
Sessionapp.Charts = {};
Sessionapp.ChartData = {};
current_node_id="801_jb";
function split_data(){
  children=[];
  jbClc={"id": Sessionapp.ChartData["infovis"].id,
        "name" : Sessionapp.ChartData["infovis"].name,
        "children":[],
        "data":Sessionapp.ChartData["infovis"].data}
  
  $.each(Sessionapp.ChartData["infovis"].children, function(index, value) {
      child={"id":value.id,
             "name":value.name,
             "data":value.data,
             "children":[]}
      children_1 = [];
      children_1[0] = jbClc;
      $.each(value.children, function(idx, val) {
          child_1={"id": val.id,
            "name" : val.name,
            "children":val.children,//todo
            "data":val.data}
          children_1_1=[];
            $.each(val.children,function(i,v){
              child_1_1 = {"id": v.id,
                    "name" : v.name,
                    "children":[],
                    "data":v.data}
              children_1_1[i] = child_1_1;
            });
            Sessionapp.ChartData[val.id]={
              "id":val.id,
              "name" : val.name,
            "children":children_1_1,
            "data":val.data};
          children_1[idx+1]=child_1;
      });
      Sessionapp.ChartData[value.id]={
        "id":value.id,
        "name" : value.name,
      "children":children_1,
      "data":value.data};
      children[index] = child;
    });
    Sessionapp.ChartData["801_jb"]={"id": Sessionapp.ChartData["infovis"].id,
      "name" : Sessionapp.ChartData["infovis"].name,
      "children":children,
      "data":Sessionapp.ChartData["infovis"].data}
      
}

Sessionapp.showPanel = function () {
w = 950;
h= 700;
split_data();

  var ht = new $jit.Hypertree({  
    //id of the visualization container  
    injectInto: 'infovis',  
    //canvas width and height  
    width: w,  
    height: h,  
    levelsToShow : 2,
    //Change node and edge styles such as  
    //color, width and dimensions.  
    Node: {  
        //dim: 40,  
        //color: "#f00",
        overridable: true,
          type: 'star',
          color: '#ccb',
          lineWidth: 1,
          height: 1,
          width: 5,
          dim: 30,
          transform: true
    },  
    Edge: {  
        lineWidth: 2,  
        color: "#088"  ,
        overridable: false,
          type: 'hyperline',
        //  color: '#ccb',
          //lineWidth: 1
    },
    Tips: {  
    enable: true,  
    type: 'native',  
    offsetX: -30,  
    offsetY: -30,  
    onShow: function(tip, node) {  
        tip.innerHTML = node.name;  
      }  
    },  
    
    Margin: {  
    right: 2,  
    top: 2  
  },
    duration: 700,
    fps: 30,
    //transition: Trans.Quart.easeInOut,
    clearCanvas: true,
    withLabels: true,  
    onBeforePlotNode:function(node) {
        
        if(node.selected) {  
          //node.setData('color', '#f00');  
        } else {  
          //node.setData('color','#ccb');  
        }  
    },
    onBeforeCompute: function(node){  
    },  
    //Attach event handlers and add text to the  
    //labels. This method is only triggered on label  
    //creation  
    onCreateLabel: function(domElement, node){  
        domElement.innerHTML = node.name;  
        

        $jit.util.addEvent(domElement, 'click', function () {  
          
        
            ht.onClick(node.id, {  
                onComplete: function() {  
                    ht.controller.onComplete();  
                }  
            });  
        });  
    },  
    //Change node styles when labels are placed  
    //or moved.  
    onPlaceLabel: function(domElement, node){  
        var style = domElement.style;  
        style.display = '';  
        style.cursor = 'pointer';  
        if (node._depth <= 1) {  
            style.fontSize = "1em";  
            style.color = "#1a1a1a";
        } else if(node._depth == 2){ 
            style.fontSize = "0.8em";  
            style.color = "#555";  
    
        } else {  
            style.display = 'none';  
        }  
    
        var left = parseInt(style.left);  
        var w = domElement.offsetWidth;  
        style.left = (left - w / 2) + 'px';  
    },  
      
    onComplete: function(){  
          
        //Build the right column relations list.  
        //This is done by collecting the information (stored in the data property)   
        //for all the nodes adjacent to the centered node.  
        var node = ht.graph.getClosestNodeToOrigin("current");  
        var html = "<h4>" + node.name + "</h4><b>Connections:</b>";  
        html += "<ul>";  
        node.eachAdjacency(function(adj){  
            var child = adj.nodeTo;  
            if (child.data) {  
                var rel = (child.data.band == node.name) ? child.data.relation : node.data.relation;  
                html += "<li>" + child.name + " " + "<div class=\"relation\">(relation: " + rel + ")</div></li>";  
                
            }
            
        });  
        html += "</ul>";  
        //$jit.id('inner-details').innerHTML = html;  
        
        current_node_id = node.id;
        if (node.data.subdomain != 'city'){
          url = '/plans?b='+node.data.brn_id;
          //$(location).attr('href',url);
          document.location.replace(url);
        }
        else
        {
          ht.loadJSON(Sessionapp.ChartData[current_node_id], 1);  
          ht.refresh(); 
        }
          
    }  
  }
  );  
  //load JSON data.  
  
  ht.loadJSON(Sessionapp.ChartData[current_node_id], 1);  
  //compute positions and plot.  
  ht.refresh(); 
 }