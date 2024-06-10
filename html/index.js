




var vehengine = new ProgressBar.Circle(garage_settings_changepart_center_bottom_right_bottom_item_1, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#f3a84f',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});
  

vehengine.animate(0.5);

var vehbrake = new ProgressBar.Circle(garage_settings_changepart_center_bottom_right_bottom_item_2, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#FF3D00',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});
vehbrake.animate(0.5);

var veharmory = new ProgressBar.Circle(garage_settings_changepart_center_bottom_right_bottom_item_3, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#8F8F8F',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});

veharmory.animate(0.5);



// ---------------------------------------------------------



var vehengine2 = new ProgressBar.Circle(vehicleinfo_item1, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#f3a84f',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});
  

// vehengine2.animate(0.5);

var vehbrake2 = new ProgressBar.Circle(vehicleinfo_item2, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#FF3D00',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});
// vehbrake2.animate(0.5);

var veharmory2 = new ProgressBar.Circle(vehicleinfo_item3, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#8F8F8F',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});

// veharmory2.animate(0.5);

// ---------------------------------------------------------


var vehengine3 = new ProgressBar.Circle(vehicleinfosell1, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#f3a84f',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});

vehengine3.animate(0.5);

var vehbrake3 = new ProgressBar.Circle(vehicleinfosell2, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#FF3D00',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});

vehbrake3.animate(0.5);
var veharmory3 = new ProgressBar.Circle(vehicleinfosell3, {
    strokeWidth: 10,
    easing: 'easeInOut',
    duration: 50,
    color: '#8F8F8F',
    trailColor: '#4C4C4C',
    trailWidth: 2,
    svgStyle: null
});

veharmory3.animate(0.5);

// ---------------------------------------------------------

var createdetails = {
    "garagetype" : "none",
    "garagecolor": "none",
    "garagename" : "none",
    "garageurl"  : "none",
    "garageprice": "none",
    "garagelimit": "none",
    "garagestars": "none",
    "garageadress": "none",
    "garagecoord": "none"
}

var createmode = false;
var buymode = false;
var entermode = false;
var settingsmode = false;
var impoundmode = false;
var vehbuymode = false;
var jobentermode = false;
var sellmode = false;


var currentbuyinfo = null;



var currentslotgaragevehs = null;
var currentgarageinfo = null;
var currentslotgaragegarageid = null;
var yeahclickslot = null;

var settingsmode_color = false;
var categoryrank = null;


var uimod = "mod_1"

var nowvehlist = 0;

var notiysound = new Audio('notify.wav');
var clicksound = new Audio('click.wav');

window.addEventListener("message", function (event) {   
    if (event.data.message == "createpart"){

        $('.garageall').fadeIn(0);
        $('.garage_create').fadeIn(300);
        $("#createimg").attr("src", "https://d1lss44hh2trtw.cloudfront.net/assets/article/2023/02/16/gta-online-gets-new-multi-floor-eclipse-boulevard-garage-free-to-gta-members_feature.jpg");
        $("#createurlid").val("https://d1lss44hh2trtw.cloudfront.net/assets/article/2023/02/16/gta-online-gets-new-multi-floor-eclipse-boulevard-garage-free-to-gta-members_feature.jpg");
        createdetails.garageurl = "https://d1lss44hh2trtw.cloudfront.net/assets/article/2023/02/16/gta-online-gets-new-multi-floor-eclipse-boulevard-garage-free-to-gta-members_feature.jpg";
        removecolorgarage();
        createmode = true;
      
    }


    if (event.data.message == "buypart"){
        $('.garageall').fadeIn(0);
        $('.garage_buy').fadeIn(300);
        buymode = true;

        $('#buyamountid').html('$'+formatMoney(event.data.garageinfobuy.garagemeta.garageprice));
        $('#buyadressid').html(event.data.garageinfobuy.garagemeta.garageadress+'.');
        $('#buygaragenameid').html(event.data.garageinfobuy.garagename+' GARAGE');
        $("#buyimageid").attr("src",event.data.garageinfobuy.garageimg);
        $("#buypartcountid").html(event.data.garageinfobuy.garagemeta.garagelimit);

        insertstars(event.data.garageinfobuy);

        setupmap(event.data.garageinfobuy);

        currentbuyinfo = event.data.garageinfobuy;

        
    }

    if (event.data.message == "closebuypart"){
        $('.garageall').fadeOut(300);
        $('.garage_buy').fadeOut(0);
        buymode = false;
        $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
        });
    }

    if (event.data.message == "garageinsert"){
        $('.garageall').fadeIn(0);
        $('.garage_enter').fadeIn(300);
        entermode = true;
      
        $('#entergaragenameid').html(event.data.garagemenu.garagename+' GARAGE');

        
        insertvehicles(event.data.garagemenu);
    }

    if (event.data.message == "closeenterpart"){
        $('.garageall').fadeOut(0);
        $('.garage_enter').fadeOut(300);
        entermode = false;
    }


    if (event.data.message == "garagevehicleinfo"){

        
        
        $("#vehinfoownid").html(event.data.infodata.vehdata.ownername);
        $("#vehinforankid").html(event.data.infodata.vehdata.vehrank);
        $('#vehinfocolor1id').css('background-color', event.data.infodata.vehdata.color1);
        $('#vehinfocolor2id').css('background-color', event.data.infodata.vehdata.color2);
        $("#vehinfoimgid").attr("src", "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/"+event.data.infodata.vehdata.model.toLowerCase()+".png" );
        $("#vehinfonameid").html(event.data.infodata.vehdata.model);
        // ---------------------------------- FUEL 2 ----------------------------- 

        $("#vehinfofuelid").html(event.data.infodata.vehdata.prop.fuelLevel+' LITERS');
        $("#vehinfenginetextid").html(Math.trunc(Number(event.data.infodata.vehdata.prop.engineHealth)) / 10 +'%');
        vehengine2.animate(Math.trunc(Number(event.data.infodata.vehdata.prop.engineHealth)) / 1000);

        // ---------------------------------- BRAKE 2 ----------------------------- 
        var braketext = "NONE"
        var brakevalue = 0.0

        if (event.data.infodata.vehdata.prop.modBrakes == 1){
            braketext = "LOW"
            brakevalue = 0.2
        }else if(event.data.infodata.vehdata.prop.modBrakes == 2){
            braketext = "MEDIUM"
            brakevalue = 0.4
        }else if(event.data.infodata.vehdata.prop.modBrakes == 3){
            braketext = "HARD"
            brakevalue = 0.7
        }else{
            braketext = "EXTRA"
            brakevalue = 1.0

        }
        $("#vehinfobraketextid").html(braketext);
        vehbrake2.animate(brakevalue);
        // ---------------------------------- BODY 2 ----------------------------- 
        $("#vehinfbodytextid").html(Math.trunc(event.data.infodata.vehdata.prop.bodyHealth) / 10 +'%');
        veharmory2.animate(Number(event.data.infodata.vehdata.prop.bodyHealth) / 1000);
       // ---------------------------------- SEAT 2 ----------------------------- 
       $("#vehinfoseattextid").html(event.data.infodata.vehdata.seat +' PEOPLE');
       // ---------------------------------- Speed 2 ----------------------------- 
       $("#vehinfospeedtextid").html(Math.trunc(Number(event.data.infodata.vehdata.speed)) +'/s');
        $(".garage_settings_changepart_center3").css({top: event.data.tops - 25 + "%", left: event.data.lefts + 8.5 + "%", position:'absolute' });
        $('.vehicleinfo').animate({ 'zoom': event.data.zoombe}, 0);
       $('.vehicleinfo').fadeIn(300);
     

      

      
    }

    if (event.data.message == "garagevehicleinfoclose"){

        $('.vehicleinfo').fadeOut(0);
        
    }


    if (event.data.message == "drawtexton"){
        $('.drwatext').fadeIn(300);
  
        $("#drawtextid").html(event.data.drawtextext);
    }

    if (event.data.message == "drawtextoff"){
        $('.drwatext').fadeOut(300);
  
       
    }

    if (event.data.message == "opensettings"){
        $('.garageall').fadeIn(0);
        $('.garage_settings_changepart').fadeIn(0);
        $('.garage_settings').fadeIn(300);
        settingsmode = true;
        $("#garagesettingsownerid").html(event.data.garagedata.garageownername);
        $("#garagesettingsvehcountid").html(event.data.garagedata.garagemeta.garagelimit);
        $("#garagesettingsownernameid").html(event.data.garagedata.garagename+' GARAGE');
        $("#garagesettingsownerimgid").attr('src', event.data.garagedata.garagemeta.garageownimg);

        insertleftslot(event.data.garagedata);

        insertrightslot(event.data.garagedata);
        $('#changepartcenterid').fadeOut(0);


        

        // console.log(JSON.stringify(event.data.garagedata.garagevehicles));

    }

    if (event.data.message == "rewritevehslots"){
        insertleftslot(event.data.data);

        insertrightslot(event.data.data);
    }


    if (event.data.message == "openallgarageui"){
        $('.garageall').fadeIn(0);
        $('.garage_enter').fadeIn(300);
        entermode = true;
        $('#entergaragenameid').html(event.data.garagedata2.label);
        insertallgaragevehicles(event.data.garagedata, event.data.garagedata2);
        vehiclestate = event.data.inveh;
        genelplayerid = event.data.generalid;

    }

    if (event.data.message == "openjobgarage"){
        $('.garageall').fadeIn(0);
        $('.buypart').fadeIn(300);
        $('#enterpartgaragenameid').html(event.data.jobclientdata.label);
        currentplayergrade = event.data.playergrade;
        insertjobgaragevehicles(event.data.jobserverdata, event.data.jobclientdata);
        

        
        jobentermode = true;
        
    }


    if (event.data.message == "openimpound"){
        $('.garageall').fadeIn(0);
        $('.garageimpound').fadeIn(200);
        insertimpound(event.data.impounddata);
        impoundmode = true;

        
    }

    if (event.data.message == "openjobbuymenu"){
        
        $('.vehjobpart_buy').fadeIn(0);
        $('#viewpart').fadeIn(200);
        currentplayergrade = event.data.playergrade;
        currentjobdata = event.data.jobdata;
        insertviewcategory(event.data.jobdata);
        $('.vehjobpart_buy_bottom_top_text').html("NONE");
        $('.vehjobpart_buy_bottom_bt_text').html("Price: 0 $");
        vehbuymode = true;
       

    }


    if (event.data.message == "opensecondsell"){
        $('.garageall').fadeIn(0);
        $('.secondvehicle').fadeIn(200);
        sellmode = true;

    }

    if (event.data.message == "closesellvehicleinfo"){
        $('.vehsellinfo').fadeOut(200);

        
    }

    if (event.data.message == "opensellvehicleinfo"){
        $('.vehsellinfo').fadeIn(200);
        $("#vehsellinfoimg").attr("src", "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/"+event.data.selldata.vehdata.model.toLowerCase()+".png" );
        $('#vehsellinfonameid').html(event.data.selldata.vehdata.model);
        $('#sellownername').html(event.data.selldata.vehdata.ownername);
        $('#sellplateid').html(event.data.selldata.vehdata.plate);
        $('#sellpriceid').html(event.data.selldata.vehdata.price+'$');
        
        

        $('#selldescid').html(event.data.selldata.vehdata.dest);


        vehengine3.animate(Math.trunc(Number(event.data.selldata.vehdata.prop.engineHealth)) / 1000);
        var braketext = "NONE"
        var brakevalue = 0.0

        if (event.data.selldata.vehdata.prop.modBrakes == 1){
            braketext = "LOW"
            brakevalue = 0.2
        }else if(event.data.selldata.vehdata.prop.modBrakes == 2){
            braketext = "MEDIUM"
            brakevalue = 0.4
        }else if(event.data.selldata.vehdata.prop.modBrakes == 3){
            braketext = "HARD"
            brakevalue = 0.7
        }else{
            braketext = "EXTRA"
            brakevalue = 1.0

        }

        vehbrake3.animate(brakevalue);

        veharmory3.animate(Number(event.data.selldata.vehdata.prop.bodyHealth) / 1000);

        if (event.data.isowner) {
            $('#deletesellvehicle').fadeIn(0);
        }else{
            $('#deletesellvehicle').fadeOut(0);

        }
        


        
        
    }

    if (event.data.message == "opensellquestion"){
        
        $('.sellconfirmpart').fadeIn(0);

        $('.sell_load').fadeIn(200);
        
        setTimeout(function() { 
            $('.sell_load').fadeOut(0);
            $('.sellconfirmpart_modal').fadeIn(200);

            
             
        }, 500);
    }
});


function confirmsellveh(){
    var getprice = $('#sellprice').val();
    var getdesc = $('#selldesc').val();
    if (getprice.length > 0 && getdesc.length > 0){
        $.post("https://bp_garage/isthissell", JSON.stringify({
            price : getprice,
            desc : getdesc
        }), function(x) {
            $('.garageall').fadeOut(0);
            $('.secondvehicle').fadeOut(200);
        });

        sellmode = false;
    }
}

function insertjobgaragevehicles(data,data2){


 $('#jobentermainid').html('');


 for (let i = 0; i < data.length; i++) {
    const element = data[i];
    if (element.vehstatus) {
        $('#jobentermainid').append('<div class="garage_jobenter_bottom_top" data-jobname = '+element.ownerjob+'  data-jobplate = '+element.plate+'> <div class="garage_enter_bottom_top_top"> <div class="garage_enter_bottom_top_top_1"> <div class="garage_enter_bottom_top_top_1_avatar"> <img src="'+data2.jobvehavatar+'" alt="" srcset=""> </div> <div class="garage_enter_bottom_top_top_1_text"> <div class="garage_enter_bottom_top_top_1_text_1"> '+element.plate+' </div> <div class="garage_enter_bottom_top_top_1_text_2"> '+element.ownerjobgrade+' </div> </div> </div> <div class="garage_enter_bottom_top_top_2"> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+element.color2+';" ></div> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+element.color1+';"></div> <div class="garage_enter_bottom_top_top_2_2">S+</div> </div> </div> <div class="garage_enter_bottom_top_center"> <img src="garagegarip.png" alt=""> </div> <div class="garage_settings_changepart_center_vehiclelogo2"> <img src="https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/'+element.model.toLowerCase()+'.png" alt=""> </div> <div class="garage_enter_bottom_top_bottom"> <div class="garage_enter_bottom_top_bottom_1"> '+element.model+' </div> <div class="garage_enter_bottom_top_bottom_2">VEHICLE</div> </div> </div>');
    }
    
    
 }

 jobenterclick();
}

function cancelsell(){
    $('.sellconfirmpart').fadeOut(0);

    $('.sellconfirmpart_modal').fadeOut(0);

    $.post("https://bp_garage/cancelsellpart", JSON.stringify({
     
    }), function(x) {

    });
}


function confirmsell(){
    $('.sellconfirmpart').fadeOut(0);

    $('.sellconfirmpart_modal').fadeOut(0);
    $.post("https://bp_garage/sellthisvehicle", JSON.stringify({
     
    }), function(x) {

    });

}


function jobenterclick() {
    $('.garage_jobenter_bottom_top').each(function(i, obj){

         
        var jobname = $(this).data("jobname");
        var jobplate = $(this).data("jobplate");

       
        $(this).click(function(){

            $.post("https://bp_garage/outjobvehicle", JSON.stringify({
                    jobname : jobname,
                    jobplate : jobplate
            }), function(x) {
        
            });
            
            $('.garageall').fadeOut(0);
            $('.buypart').fadeOut(300);
           
            jobentermode = false;
            $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
   
            });

          
        })

    });
}


function insertviewcategory(data){
$('.vehjobpart_buy_left_menu_1').html('');
 for (const key in  data.ranks) {
    if (Object.hasOwnProperty.call( data.ranks, key)) {
        const element =  data.ranks[key];
        $('.vehjobpart_buy_left_menu_1').append('<div data-jobclickgrade = "'+key+'" class="vehjobpart_buy_left_menu_1_item">🚓 '+key[0].toUpperCase() + key.slice(1)+'  </div>');
        
    }
 }

 clickjobcategory();
}

function clickjobcategory(){
    $('.vehjobpart_buy_left_menu_1_item').each(function(i, obj){

         
        
       
        $(this).click(function(){
            categoryrank = $(this).data("jobclickgrade");
      
            console.log(currentplayergrade)
            if (categoryrank == currentplayergrade){
                nowvehlist = 0
     
                $('.vehjobpart_buy_bottom_top_text').html(currentjobdata.ranks[categoryrank][0].vehlabel);
                $('.vehjobpart_buy_bottom_bt_text').html("Price: "+currentjobdata.ranks[categoryrank][0].vehprice+" $");

                

                $.post("https://bp_garage/viewlocalveh", JSON.stringify({
                    newvehdata : currentjobdata.ranks[categoryrank][0],
                    newdata : currentjobdata
                  
            
                }), function(x) {
            
                });

                
            }else{
                console.log('your rank is not good');
            }
          
            
         
         
        })

    });
}



function rightarrowchange(){
   if (categoryrank != null){
      if (categoryrank == currentplayergrade){
        nowvehlist = nowvehlist + 1
        if (currentjobdata.ranks[categoryrank][Number(nowvehlist)] == undefined){
            nowvehlist = nowvehlist - 1
        }

            $.post("https://bp_garage/viewlocalveh", JSON.stringify({
                newvehdata : currentjobdata.ranks[categoryrank][Number(nowvehlist)],
                newdata : currentjobdata
                

            }), function(x) {

             });

             $('.vehjobpart_buy_bottom_top_text').html(currentjobdata.ranks[categoryrank][Number(nowvehlist)].vehlabel);
             $('.vehjobpart_buy_bottom_bt_text').html("Price: "+currentjobdata.ranks[categoryrank][Number(nowvehlist)].vehprice+" $");
      }
    }
   
}

function leftarrowchange(){
    if (categoryrank != null){
        if (categoryrank == currentplayergrade){
            if ( nowvehlist > 0){
                nowvehlist = nowvehlist - 1
                $.post("https://bp_garage/viewlocalveh", JSON.stringify({
                    newvehdata : currentjobdata.ranks[categoryrank][Number(nowvehlist)],
                    newdata : currentjobdata
                
            
                }), function(x) {
            
                });
                $('.vehjobpart_buy_bottom_top_text').html(currentjobdata.ranks[categoryrank][Number(nowvehlist)].vehlabel);
                $('.vehjobpart_buy_bottom_bt_text').html("Price: "+currentjobdata.ranks[categoryrank][Number(nowvehlist)].vehprice+" $");
            }
        }
    }   
}


function insertimpound(data){
    $('.garageimpound_list').html('');

    for (let i = 0; i < data.length; i++) {
        const element = data[i];
        if (element.garageid == "none"){
            $('.garageimpound_list').append('<div data-plate = "'+element.plate+'" data-price = "'+element.impoundcost+'" data-impoundst = "'+element.impound+'" class="garageimpound_list_item"> <div class="garageimpound_list_item_1"> <i class="fa fa-car item_ekle" aria-hidden="true" ></i> <div class="garageimpound_list_item_1_1">'+element.model+'</div> <div class="garageimpound_list_item_1_2"> - '+element.plate+'</div> </div> <div class="garageimpound_list_item_2"> <div class="garageimpound_list_item_2_1">'+element.impoundcost+'</div> <i class="fa fa-usd item_ekle2" aria-hidden="true"></i> </div> </div>');
        }
       
    }


    enterimpoundclick();

}

function enterimpoundclick(){
    $('.garageimpound_list_item').each(function(i, obj){

        
       
        $(this).click(function(){

            impoundplate = $(this).data("plate");
            impoundstate = $(this).data("impoundst");
            impoundprice = $(this).data("price");

           $('.garageimpound_load').fadeIn(100);

           setTimeout(function() { 
           $('.garageimpound_load').fadeOut(0);
           $('.garageimpound_modal').fadeIn(500);
            
           }, 500);
            
         
         
        })

    });
}


function confirmimpound(){
  
   
    $.post("https://bp_garage/outimpound", JSON.stringify({
        impound : impoundplate ,
        price : impoundprice,
        state : impoundstate

    }), function(x) {

    });

    $('.garageall').fadeOut(300);
    $('.garageimpound').fadeOut(0);
    $('.garageimpound_modal').fadeOut(0);
    impoundmode = false;
    $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {

    });

}


function cancelimpound(){
    $('.garageimpound_modal').fadeOut(200);

}




function insertallgaragevehicles(data, data2) {
    uimod = "mod_2";
   
    $('#entervehicleid').html('');

    for (let i = 0; i < Number(data2.maxvehicle); i++) {
        
        if (data.garagevehicles[i].slot == (i + 1)) {
           if (data.garagevehicles[i].vehdata == null){
            $('#entervehicleid').append('<div data-slotid = "'+i+'" data-garageid = "'+data.garageid+'" data-entertype = "freeslot" class="garage_enter_bottom_top2"> <div class="garage_enter_bottom_top_top"> <div class="garage_enter_bottom_top_top_1" style="z-index: 3;"> <div class="garage_enter_bottom_top_top_1_avatar" style="background-color:#1D1D1D;z-index: 3;" > </div> </div> </div> <div class="garage_enter_bottom_top_center" style="z-index: 1;"> <img src="emptygrp.png" alt=""> </div> <div class="garage_enter_bottom_top2_centertext"> <div class="garage_enter_bottom_top2_centertext_1">SELECT</div> <div class="garage_enter_bottom_top2_centertext_2">GARAGE</div> </div> </div>')
           }else{
            // var imagestate = UrlExists('https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/'+data.garagevehicles[i].vehdata.model.toLowerCase()+'.png');
            // if (imagestate) {
            newimageurl = 'https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/'+data.garagevehicles[i].vehdata.model.toLowerCase()+'.png'
            // }else{
            //     newimageurl = 'customimages/'+data.garagevehicles[i].vehdata.model+'.png'

            // }
            $('#entervehicleid').append('<div data-ownerid = "'+data.garagevehicles[i].vehdata.ownerid+'" data-slotid = "'+i+'" data-garageid = "'+data.garageid+'" data-entertype = "activeslot" class="garage_enter_bottom_top"> <div class="garage_enter_bottom_top_top"> <div class="garage_enter_bottom_top_top_1"> <div class="garage_enter_bottom_top_top_1_avatar"> <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOtefq6hB8q_4FfMAbTphPUBm0VQLFQXfFQ&usqp=CAU" alt="" srcset=""> </div> <div class="garage_enter_bottom_top_top_1_text"> <div class="garage_enter_bottom_top_top_1_text_1"> '+data.garagevehicles[i].vehdata.ownername+' </div> <div class="garage_enter_bottom_top_top_1_text_2"> OWNER </div> </div> </div> <div class="garage_enter_bottom_top_top_2"> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+data.garagevehicles[i].vehdata.color1+';"></div> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+data.garagevehicles[i].vehdata.color2+';"></div> <div class="garage_enter_bottom_top_top_2_2">'+data.garagevehicles[i].vehdata.vehrank+'</div> </div> </div> <div class="garage_enter_bottom_top_center"> <img src="garagegarip.png" alt=""> </div> <div class="garage_settings_changepart_center_vehiclelogo2"> <img src="'+newimageurl+'" alt=""> </div> <div class="garage_enter_bottom_top_bottom"> <div class="garage_enter_bottom_top_bottom_1"> '+data.garagevehicles[i].vehdata.model+' </div> <div class="garage_enter_bottom_top_bottom_2">VEHICLE</div> </div> </div>')
           }
        }else{
           console.log('helpp2')

        }
    
    }

    enterclickonline();
    
}




function insertleftslot(data){
    $('#settingsleftid').html('');
    currentgarageinfo = data;
    currentslotgaragevehs = data.garagemeta.garagevehicles;
    currentslotgaragegarageid = data.garageid;
    for (let i = 0; i < data.garagemeta.garagevehicles.length; i++) {
        const element = data.garagemeta.garagevehicles[i];
        if ((i + 1) <= 5){
            if (data.garagemeta.garagevehicles[i].slot == (i + 1)){
                if (data.garagemeta.garagevehicles[i].vehdata == null){
                    
                    $('#settingsleftid').append('<div data-clickvehdata = "'+i+'" data-clickvehtype = "free" class="garage_settings_changepart_left_item"> <div class="garage_settings_changepart_left_item_1"> <img src="park1.png" alt="" style="margin-left: 30px;"> </div> </div>')
                }else{
                    $('#settingsleftid').append('<div data-clickvehdata = "'+i+'" data-clickvehtype = "full" class="garage_settings_changepart_left_item"> <div class="garage_settings_changepart_left_item_1"> <img src="'+data.garagemeta.garagevehicles[i].vehdata.ownerimg+'" alt="" style="margin-left: 30px;"> </div> </div>')

                }
            }

        }
        
    }

    clickleftslot();
}

function clickleftslot(){
    $('.garage_settings_changepart_left_item').each(function(i, obj){

        var clickvehdata = $(this).data("clickvehdata");
        var clickvehtype = $(this).data("clickvehtype");
     

        $(this).click(function(){

         
            if (clickvehtype == "full"){
                $('#changepartcenterid').fadeIn(0);
                writenewui(clickvehdata);
                yeahclickslot = clickvehdata;
 
             }else if (clickvehtype == "free"){
                $('#changepartcenterid').fadeOut(0);
 
                if (yeahclickslot != null){
 
                 currentslotgaragegarageid
                 $.post("https://bp_garage/changevehslot", JSON.stringify({
                     oldslotid : Number(yeahclickslot) + 1 ,
                     newslotid : Number(clickvehdata) + 1,
                     garageid : currentslotgaragegarageid
 
                 }), function(x) {
        
                 });
 
                }else{
 
                } 
 
                 yeahclickslot = null;
             }
             
            


        })

    });
}


function clickrightslot(){
    $('.garage_settings_changepart_right_item').each(function(i, obj){

        var clickvehdata = $(this).data("clickvehdata");
        var clickvehtype = $(this).data("clickvehtype");
     

        $(this).click(function(){

            if (clickvehtype == "full"){
               $('#changepartcenterid').fadeIn(0);
               writenewui(clickvehdata);
               yeahclickslot = clickvehdata;

            }else if (clickvehtype == "free"){
               $('#changepartcenterid').fadeOut(0);

               if (yeahclickslot != null){

                currentslotgaragegarageid
                $.post("https://bp_garage/changevehslot", JSON.stringify({
                    oldslotid : Number(yeahclickslot) + 1 ,
                    newslotid : Number(clickvehdata) + 1,
                    garageid : currentslotgaragegarageid

                }), function(x) {
       
                });

               }else{

               } 

                yeahclickslot = null;
            }
            


        })

    });
}

function writenewui(dataid){
    $("#vehinfoownid2").html(currentslotgaragevehs[dataid].vehdata.ownername);
    $('#vehinfocolor1id2').css('background-color', currentslotgaragevehs[dataid].vehdata.color1);
    $('#vehinfocolor2id2').css('background-color', currentslotgaragevehs[dataid].vehdata.color2);
    $("#vehinfoimgid2").attr("src", "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/"+currentslotgaragevehs[dataid].vehdata.model.toLowerCase()+".png" );
    $("#vehinfonameid2").html(currentslotgaragevehs[dataid].vehdata.model);
     // ---------------------------------- FUEL 1 ----------------------------- 

     $("#vehinfofuelid2").html(currentslotgaragevehs[dataid].vehdata.prop.fuelLevel+' LITERS');
     $("#vehinfenginetextid2").html(Math.trunc(Number(currentslotgaragevehs[dataid].vehdata.prop.engineHealth)) / 10 +'%');
     vehengine.animate(Math.trunc(Number(currentslotgaragevehs[dataid].vehdata.prop.engineHealth)) / 1000);

     // ---------------------------------- BRAKE 1 ----------------------------- 
     var braketext = "NONE"
     var brakevalue = 0.0

     if (currentslotgaragevehs[dataid].vehdata.prop.modBrakes == 1){
         braketext = "LOW"
         brakevalue = 0.2
     }else if(currentslotgaragevehs[dataid].vehdata.prop.modBrakes == 2){
         braketext = "MEDIUM"
         brakevalue = 0.4
     }else if(currentslotgaragevehs[dataid].vehdata.prop.modBrakes == 3){
         braketext = "HARD"
         brakevalue = 0.7
     }else{
         braketext = "EXTRA"
         brakevalue = 1.0

     }
     $("#vehinfobraketextid2").html(braketext);
     vehbrake.animate(brakevalue);

     // ---------------------------------- BODY 1 ----------------------------- 
     $("#vehinfbodytextid2").html(Math.trunc(currentslotgaragevehs[dataid].vehdata.prop.bodyHealth) / 10 +'%');
     veharmory.animate(Number(currentslotgaragevehs[dataid].vehdata.prop.bodyHealth) / 1000);
    // ---------------------------------- SEAT 1 ----------------------------- 
    $("#vehinfoseattextid2").html(currentslotgaragevehs[dataid].vehdata.seat +' PEOPLE');
    // ---------------------------------- Speed 1 ----------------------------- 
    $("#vehinfospeedtextid2").html(Math.trunc(Number(currentslotgaragevehs[dataid].vehdata.speed)) +'/s');
}

function insertrightslot(data){
    $('#settingsrightid').html('');
    currentgarageinfo = data;
    currentslotgaragevehs = data.garagemeta.garagevehicles;
    currentslotgaragegarageid = data.garageid;
    for (let i = 5; i < data.garagemeta.garagevehicles.length; i++) {
        const element = data.garagemeta.garagevehicles[i];
        if ((i + 1) <= 10){
            if (data.garagemeta.garagevehicles[i].slot == (i + 1)){
                if (data.garagemeta.garagevehicles[i].vehdata == null){
                    $('#settingsrightid').append('<div data-clickvehdata = "'+i+'" data-clickvehtype = "free" class="garage_settings_changepart_right_item"> <div class="garage_settings_changepart_right_item_1"> <img src="park1.png" alt="" style="margin-left: 30px;"> </div> </div>')
                }else{
                    $('#settingsrightid').append('<div data-clickvehdata = "'+i+'" data-clickvehtype = "full" class="garage_settings_changepart_right_item"> <div class="garage_settings_changepart_right_item_1"> <img src="'+data.garagemeta.garagevehicles[i].vehdata.ownerimg+'" alt="" style="margin-left: 30px;"> </div> </div>')

                }
            }

        }
        
    }

    clickrightslot();

}

function insertvehicles(data) {
    uimod = "mod_1";

    $('#entervehicleid').html('');

    for (let i = 0; i < Number(data.garagemeta.garagelimit); i++) {
        if (data.garagemeta.garagevehicles[i].slot == (i + 1)) {
           if (data.garagemeta.garagevehicles[i].vehdata == null){
            $('#entervehicleid').append('<div data-slotid = "'+i+'" data-garageid = "'+data.garageid+'" data-entertype = "freeslot" class="garage_enter_bottom_top2"> <div class="garage_enter_bottom_top_top"> <div class="garage_enter_bottom_top_top_1" style="z-index: 3;"> <div class="garage_enter_bottom_top_top_1_avatar" style="background-color:#1D1D1D;z-index: 3;" > </div> </div> </div> <div class="garage_enter_bottom_top_center" style="z-index: 1;"> <img src="emptygrp.png" alt=""> </div> <div class="garage_enter_bottom_top2_centertext"> <div class="garage_enter_bottom_top2_centertext_1">SELECT</div> <div class="garage_enter_bottom_top2_centertext_2">GARAGE</div> </div> </div>')
           }else{
           
            $('#entervehicleid').append('<div data-slotid = "'+i+'" data-garageid = "'+data.garageid+'" data-entertype = "activeslot" class="garage_enter_bottom_top"> <div class="garage_enter_bottom_top_top"> <div class="garage_enter_bottom_top_top_1"> <div class="garage_enter_bottom_top_top_1_avatar"> <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOtefq6hB8q_4FfMAbTphPUBm0VQLFQXfFQ&usqp=CAU" alt="" srcset=""> </div> <div class="garage_enter_bottom_top_top_1_text"> <div class="garage_enter_bottom_top_top_1_text_1"> '+data.garagemeta.garagevehicles[i].vehdata.ownername+' </div> <div class="garage_enter_bottom_top_top_1_text_2"> OWNER </div> </div> </div> <div class="garage_enter_bottom_top_top_2"> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+data.garagemeta.garagevehicles[i].vehdata.color1+';"></div> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+data.garagemeta.garagevehicles[i].vehdata.color2+';"></div> <div class="garage_enter_bottom_top_top_2_2">'+data.garagemeta.garagevehicles[i].vehdata.vehrank+'</div> </div> </div> <div class="garage_enter_bottom_top_center"> <img src="garagegarip.png" alt=""> </div> <div class="garage_settings_changepart_center_vehiclelogo2"> <img src="https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/'+data.garagemeta.garagevehicles[i].vehdata.model.toLowerCase()+'.png" alt=""> </div> <div class="garage_enter_bottom_top_bottom"> <div class="garage_enter_bottom_top_bottom_1"> '+data.garagemeta.garagevehicles[i].vehdata.model+' </div> <div class="garage_enter_bottom_top_bottom_2">VEHICLE</div> </div> </div>')
           }
        }else{
           console.log('helpp2')

        }
        // if (data.garagemeta.garagevehicles[i] == undefined) {
        //     console.log('boş slot')
        //     $('#entervehicleid').append('<div data-slotid = "'+i+'" data-garageid = "'+data.garageid+'" data-entertype = "freeslot" class="garage_enter_bottom_top2"> <div class="garage_enter_bottom_top_top"> <div class="garage_enter_bottom_top_top_1" style="z-index: 3;"> <div class="garage_enter_bottom_top_top_1_avatar" style="background-color:#1D1D1D;z-index: 3;" > </div> </div> </div> <div class="garage_enter_bottom_top_center" style="z-index: 1;"> <img src="emptygrp.png" alt=""> </div> <div class="garage_enter_bottom_top2_centertext"> <div class="garage_enter_bottom_top2_centertext_1">SELECT</div> <div class="garage_enter_bottom_top2_centertext_2">GARAGE</div> </div> </div>')
        // }else{
        //     console.log('dolu slot')
        
        //     $('#entervehicleid').append('<div data-slotid = "'+i+'" data-garageid = "'+data.garageid+'" data-entertype = "activeslot" class="garage_enter_bottom_top"> <div class="garage_enter_bottom_top_top"> <div class="garage_enter_bottom_top_top_1"> <div class="garage_enter_bottom_top_top_1_avatar"> <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOtefq6hB8q_4FfMAbTphPUBm0VQLFQXfFQ&usqp=CAU" alt="" srcset=""> </div> <div class="garage_enter_bottom_top_top_1_text"> <div class="garage_enter_bottom_top_top_1_text_1"> '+data.garagemeta.garagevehicles[i].ownername+' </div> <div class="garage_enter_bottom_top_top_1_text_2"> OWNER </div> </div> </div> <div class="garage_enter_bottom_top_top_2"> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+data.garagemeta.garagevehicles[i].color1+';"></div> <div class="garage_enter_bottom_top_top_2_1" style="background-color: '+data.garagemeta.garagevehicles[i].color2+';"></div> <div class="garage_enter_bottom_top_top_2_2">S+</div> </div> </div> <div class="garage_enter_bottom_top_center"> <img src="garagegarip.png" alt=""> </div> <div class="garage_settings_changepart_center_vehiclelogo2"> <img src="https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/'+data.garagemeta.garagevehicles[i].model.toLowerCase()+'.png" alt=""> </div> <div class="garage_enter_bottom_top_bottom"> <div class="garage_enter_bottom_top_bottom_1"> '+data.garagemeta.garagevehicles[i].model+' </div> <div class="garage_enter_bottom_top_bottom_2">VEHICLE</div> </div> </div>')
        // }
    }

    enterclickonline();
    
}

function UrlExists(url) {
    var http = new XMLHttpRequest();
    http.open('HEAD', url, false);
    http.send();
    if (http.status != 404){
        return true;
    }else{
        return false;

    }
     
}


function enterclickonline() {

    $('.garage_enter_bottom_top2').each(function(i, obj){
        
            var slotid = $(this).data("slotid");
            var garageid = $(this).data("garageid");
            var entertype = $(this).data("entertype");
        
       
            $(this).click(function(){
                if (uimod == "mod_1"){
                    if (entertype == "freeslot"){
                        $.post("https://bp_garage/grginsertveh", JSON.stringify({
                            slotid : Number(slotid) + 1,
                            garageid : garageid

                        }), function(x) {
            
                        });

                    }
                }else if (uimod == "mod_2"){

                    if (entertype == "freeslot"){
                        $.post("https://bp_garage/grginsertvehall", JSON.stringify({
                            slotid : Number(slotid) + 1,
                            garageid : garageid,
                            state : vehiclestate

                        }), function(x) {
            
                        });

                    }
                }
                


            })
       

       

    });

    $('.garage_enter_bottom_top').each(function(i, obj){
        var slotid = $(this).data("slotid");
        var garageid = $(this).data("garageid");
        var entertype = $(this).data("entertype");
        var ownerid = $(this).data("ownerid");

        $(this).click(function(){
            if (ownerid == genelplayerid){
                if (uimod == "mod_2"){
                    if (entertype == "activeslot"){
                        $.post("https://bp_garage/outvehicleall", JSON.stringify({
                            slotid : Number(slotid) + 1,
                            garageid : garageid,
                            state : vehiclestate

                        }), function(x) {
            
                        });
                    }
                }
            }
        })
    });
    
}










function setupmap(data){

    var marker = L.marker(gtaToLatLng(data.garagemeta.garagecoord.x, data.garagemeta.garagecoord.y));
    
    marker.addTo(map);

    setTimeout(function(){ 
        map.invalidateSize()
        map.setView(gtaToLatLng(data.garagemeta.garagecoord.x, data.garagemeta.garagecoord.y), 4);
  
    }, 0);
}


function insertstars(data ){
   
    $('#starsid').html('');
    
   for (let i = 0; i < 5; i++) {
    if (i < data.garagemeta.garagestars){
        $('#starsid').append('<span class="fa fa-star leftcheck fa-lg" ></span>');
    }else{
        $('#starsid').append(' <span class="fa fa-star checked fa-lg" style="margin-right:5px;"></span>');

    }

  
    
   }
}


function formatMoney(number, decPlaces, decSep, thouSep) {
    decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? 2 : decPlaces,
    decSep = typeof decSep === "undefined" ? "." : decSep;
    thouSep = typeof thouSep === "undefined" ? "," : thouSep;
    var sign = number < 0 ? "-" : "";
    var i = String(parseInt(number = Math.abs(Number(number) || 0).toFixed(decPlaces)));
    var j = (j = i.length) > 3 ? j % 3 : 0;

    return sign +
        (j ? i.substr(0, j) + thouSep : "") +
        i.substr(j).replace(/(\decSep{3})(?=\decSep)/g, "$1" + thouSep) +
        (decPlaces ? decSep + Math.abs(number - i).toFixed(decPlaces).slice(2) : "");
}


function createclick() {

   var yeah = false;

  for (const key in createdetails) {
    if (Object.hasOwnProperty.call(createdetails, key)) {
        const element = createdetails[key];
        if (element == "none" && key != "garagelimit" && key != "garagestars"){
          yeah = true;
          break
        }
        
    }
  }


 

  if (yeah == false){

    $('.garageall').fadeOut(300);
       

        $.post("https://bp_garage/creategarage", JSON.stringify({
            garageinfo : createdetails
        }), function(x) {
        
        });

        $('.garage_create').fadeOut(0);
        removetypehover();
        removecolorgarage(); 
        clearinputscreate();
        createmode = false;
        createdetails = { "garagetype" : "none", "garagecolor": "none", "garagename" : "none", "garageurl"  : "none", "garageprice": "none", "garagecoord": "none" };

  }else{
    

    console.log('EKSIK VAR')
  }

    
}


function garagetypefnc(tip){
   
    removetypehover();

    $('#'+tip).addClass("garagetypehover");

    createdetails.garagetype = tip;

    clicksound.play();
}



function colorselectgrg(color) {
    removecolorgarage();

    $('#'+color).addClass("garagecolorhover");

    createdetails.garagecolor = color;
}


$('#createnameid').on('input',function(e){
    createdetails.garagename = $(this).val();
});

$('#createurlid').on('input',function(e){
    createdetails.garageurl = $(this).val();
});

$('#createpriceid').on('input',function(e){
    createdetails.garageprice = $(this).val();
});



function takephoto() {

    $('.garageall').fadeOut(300);

    $.post("https://bp_garage/takeImg", JSON.stringify({}), function(x) {
        if (x != "[]") {
            document.getElementById("createimg").src = x;
            createdetails.garageurl = x;
            $('#createurlid').val(x);
        }
      
       $('.garageall').fadeIn(300);
    });
}


function selectcoord() {

    $('.garageall').fadeOut(300);

    $.post("https://bp_garage/selectcoord", JSON.stringify({}), function(x) {
     
       if (x != null) {
          createdetails.garagecoord = x;
         
       }
       
       
       $('.garageall').fadeIn(300);
    });


    $.post("https://bp_garage/getadress", JSON.stringify({}), function(x) {
        createdetails.garageadress = x;

       
    });
}



document.onkeyup = function(data) {
    
    if ( data.which == 27) {     
            if (createmode == true){
                $('.garageall').fadeOut(300);
                $('.garage_create').fadeOut(0);
                removetypehover();
                removecolorgarage(); 
                clearinputscreate();
                createmode = false;
                createdetails = { "garagetype" : "none", "garagecolor": "none", "garagename" : "none", "garageurl"  : "none", "garageprice": "none", "garagecoord": "none" };
                $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
                });
            }


            if (buymode == true){
                $('.garageall').fadeOut(0);
                $('.garage_buy').fadeOut(300);
                buymode = false;
                $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
                });
            }

            if (entermode == true){
                $('.garageall').fadeOut(0);
                $('.garage_enter').fadeOut(300);
                entermode = false;
                $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
                });
            }


            if (settingsmode == true){
                $('.garageall').fadeOut(300);
                $('.garage_settings').fadeOut(0);
                $('.garage_settings_changepart').fadeOut(0);
               
                settingsmode = false;
                $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
                });
            }


            if (impoundmode == true){
                $('.garageall').fadeOut(300);
                $('.garageimpound').fadeOut(0);
                $('.garageimpound_modal').fadeOut(0);
                impoundmode = false;
                $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
                });
            }

            if (vehbuymode == true){
                $('.vehjobpart_buy').fadeOut(0);
                $('#viewpart').fadeOut(200); 
                vehbuymode = false;
                categoryrank = null;
                $.post("https://bp_garage/closeui2", JSON.stringify({}), function(x) {
       
                });
            }

            if (jobentermode == true){
                $('.garageall').fadeOut(0);
                $('.buypart').fadeOut(300);
               
                jobentermode = false;
                $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
                });
            }

            if (sellmode == true){
                $('.garageall').fadeOut(0);
                $('.secondvehicle').fadeOut(200);
               
                sellmode = false;
                $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {
       
                });
            }
       
            
            
    }
}


function closegaragesettings() {
    $('.garageall').fadeOut(300);
    $('.garage_settings').fadeOut(0);
    $('.garage_settings_changepart').fadeOut(0);
   
    settingsmode = false;
    $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {

    });
}

function changecolorset(number) {


    $.post("https://bp_garage/changegaragecolor", JSON.stringify({
        garageid : currentslotgaragegarageid,
        newcolor : number

    }), function(x) {

    });
}


function garagesettingscolor() {

    if (settingsmode_color == false){
        $('.garage_settings_changepart').fadeOut(200);
        $('.garage_settings_colorpart').fadeIn(200);
        settingsmode_color = true;
    }else{

        $('.garage_settings_changepart').fadeIn(200);
        $('.garage_settings_colorpart').fadeOut(200);
        settingsmode_color = false;
    }


    
}



function exitenterjobpart() {
    $('.garageall').fadeOut(0);
    $('.buypart').fadeOut(300);
   
    jobentermode = false;
    $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {

    });
}

function exitentergarage() {
    $('.garageall').fadeOut(0);
    $('.garage_enter').fadeOut(300);
    entermode = false;
    $.post("https://bp_garage/closeui", JSON.stringify({}), function(x) {

    });

    
}


function removetypehover(){
    $('#lowgarage').removeClass("garagetypehover");
    $('#midgarage').removeClass("garagetypehover");
    $('#highgarage').removeClass("garagetypehover");
    $('#premiumgarage').removeClass("garagetypehover");
}

function removecolorgarage() {
    $('#bluecolor').removeClass("garagecolorhover");
    $('#orangecolor').removeClass("garagecolorhover");
    $('#greencolor').removeClass("garagecolorhover");
    $('#redcolor').removeClass("garagecolorhover");
}


function clearinputscreate() {
    $('#createnameid').val('');
    $('#createurlid').val('');
    $('#createpriceid').val('');

}


function buytogarage(){
    $.post("https://bp_garage/buytogarage", JSON.stringify({
        currentbuyinfo :currentbuyinfo
    }), function(x) {
       
    });
}



// ------------------- map part ------------------------ ------------------------ ------------------------ ------------------------ 

var mapMinZoom = 2;
var mapMaxZoom = 7;
var mapMaxResolution = 0.25;
var mapMinResolution = Math.pow(2, mapMaxZoom) * mapMaxResolution;
var mapCenterLat = -5525;
var mapCenterLng = 3755;
var gtaOffset = 0.66;
var debug = false;
var overlay = false;
var bottomLeft = [-8192, 0];
var topRight = [0, 8192];
var bounds = [bottomLeft, topRight];

var crs = L.CRS.Simple;

crs.scale = function (zoom) {
    return Math.pow(2, zoom) / mapMinResolution;
};

var layer = L.tileLayer("https://skyrossm.github.io/PolyZoneCreator/tiles/{z}/{x}/{y}.png", {
    minZoom: mapMinZoom,
    maxZoom: mapMaxZoom,
    noWrap: true,
    tms: true,
});

var map = new L.Map("map1", {
    maxZoom: mapMaxZoom,
    minZoom: mapMinZoom,
    layers: [layer],
    crs: crs,
    center: [mapCenterLat, mapCenterLng],
    zoom: 1,
    zoomControl: false,
});

function latlngToGTA(latlng) {
    var x = (latlng.lng - mapCenterLng) / gtaOffset;
    var y = (latlng.lat - mapCenterLat) / gtaOffset;
    return [x.toFixed(2), y.toFixed(2)];
}

function gtaToLatLng(x, y) {
    var lng = x * gtaOffset + mapCenterLng;
    var lat = y * gtaOffset + mapCenterLat;
  
    return L.latLng(lat, lng);
}

map.on("load",function() { setTimeout(() => {
   map.invalidateSize();
}, 1); });
     
map.setView([-6156, 3748], 1);
// ------------------------ ------------------------ ------------------------ ------------------------ ------------------------ ------------------------ 


function buyjobvehicle(){
    $('.jobbuy_load').fadeIn(0);
    setTimeout(function() { 
        $('.jobbuy_load').fadeOut(0);
        
        $.post("https://bp_garage/buythisjobveh", JSON.stringify({
            newvehdata : currentjobdata.ranks[categoryrank][Number(nowvehlist)],
            newdata : currentjobdata
        }), function(x) {
           
        });

        $('.vehjobpart_buy').fadeOut(0);
        $('#viewpart').fadeOut(200); 
        vehbuymode = false;
        categoryrank = null;
        $.post("https://bp_garage/closeui2", JSON.stringify({}), function(x) {

        });

    }, 500);


}