
var torsades = false;
var asystole = []; 
var vTach = [0,2,5,8,10,12,15,18,20,28,30,33,50,52,56,52,40,30,20,15,10,5];
var vFib = [0];
var nsr = [0,0,0,0,5,10,14,16,17,16,14,10,7,5,4,3,2,1,0,-2,-4,-6,10,46,20,10,0,0,0,-5,0,0,0,5,6,7,8,9,9,9,8,7,6,5,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
var rhythm = asystole;

var o2nsr = [0,0,0,1,4,6,8,10,12,15,18,20,24,26,28,31,34,37,40,42,44,45,45,45,45,45,45,44,43,42,41,41,41,41,41,41,41,39,38,36,33,31,31,30,29,27,27,27,27,27,27,27,27,27,26,26,26,25,25,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0];
var o2rhythm = o2nsr;

var active = true;

var posx;
var posy;
var posz;
var DamageList = [];
var pulse = 0;
var oxygenSaturation = 0;

var oldrythm = 'NSR';

window.addEventListener("message", function(ev) {
    const data = ev.data;

    if (data.index){
        var index = document.querySelector(".value5");
        index.innerHTML = "ICU "+data.index;
    }

    if (data.reset){
        var bpm = document.querySelector(".value1");
        bpm.innerHTML = 0;

        var bp = document.querySelector(".value2");
        bp.innerHTML = "0/0";

        var o2 = document.querySelector(".value3");
        o2.innerHTML = "0%";

        var temp = document.querySelector(".value4");
        temp.innerHTML = "0°C";

        pulse = 0;
        oxygenSaturation = 0;
        rhythm = asystole;
    }

    if (data.damageStats) {
        DamageList = data.damageStats;
        DamageList = JSON.parse(DamageList);
        posx = data.posx;
        posy = data.posy;
        posz = data.posz;

        var bpm = document.querySelector(".value1");
        bpm.innerHTML = Math.round(DamageList.Pulse / 1) * 1;

        var bp = document.querySelector(".value2");
        bp.innerHTML = DamageList.BloodPressure[0]+"/"+DamageList.BloodPressure[1];

        var o2 = document.querySelector(".value3");
        o2.innerHTML = DamageList.oxygenSaturation+"%";

        var temp = document.querySelector(".value4");
        temp.innerHTML = DamageList.Temp+"°C";

        pulse = Math.round(DamageList.Pulse / 1) * 1;
        oxygenSaturation = DamageList.oxygenSaturation;
    }

    function changeNSR(){
        rhythm = nsr;
        torsades = false;
    }

    function changevTach(){
        rhythm = vTach;
        torsades = true;
    }

    function changetorsades(){
        rhythm = vTach;
        torsades = false;
    }

    function changevFib(){
        rhythm = vFib;
        torsades = false;
    }

    function changeasytole(){
        rhythm = asystole;
        torsades = false;
    }
    
    if (data.rythm == 'NSR') {
        changeNSR();
    }

    if (oldrythm != data.rythm) {
        oldrythm = data.rythm;
        if (data.rythm == 'NSR') {
            changeNSR();
        } else if (data.rythm == 'vTach') {
            changevTach();
        } else if (data.rythm == 'torsades') {
            changetorsades();
        } else if (data.rythm == 'vFib') {
            changevFib();
            $.post("https://osp_ambulance/crash", JSON.stringify({coordx : posx, coordy : posy, coordz : posz}))
            setTimeout(function() {
                if (data.rythm == 'vFib'){
                    changeasytole();
                }
            }, 28000);
        } else if (data.rythm == 'asystole') {
            changeasytole();
            $.post("https://osp_ambulance/flat", JSON.stringify({coordx : posx, coordy : posy, coordz : posz}))
        } 
    }


});


setTimeout(function() {



    var Graph = function(canvas){
        //init parameters
        if(typeof canvas == 'string'){
            canvas = document.getElementById(canvas);
        }


        //set up the height and width
        canvas.setAttribute('width',canvas.offsetWidth);
        canvas.setAttribute('height',canvas.offsetHeight);

        //set up canvas colors
        canvas.style.backgroundColor = 'rgba(25,25,25,0)';

        //variables
        var width = canvas.offsetWidth;
        var height = canvas.offsetHeight;

        var ctx = canvas.getContext('2d');
        var gridTileWidth = 60;
        var currentXvalue = 0;
        var lastYvalue = 0;


        //global functions

        this.drawValue = function(value){
            drawValue(value);
        }

        this.getTimeInterval = function(){
            return 600 / (gridTileWidth * 0.7);
        }

        //functions

        function drawGrid(){
            ctx.lineWidth = 1;
            var i;
            var verticalGridTiles = width / gridTileWidth;
            var horizontalGridTiles = height / gridTileWidth;
            for(i = 0;i < verticalGridTiles;i++){
            ctx.beginPath();
            if(i / 5 == Math.round(i / 5)){
                ctx.strokeStyle = 'rgb(60,60,60)';
                ctx.lineWidth = 5;
            }else{
                ctx.strokeStyle = 'rgb(40,40,40)';
                ctx.lineWidth = 5;
            }
            ctx.moveTo(i * gridTileWidth,0);
            ctx.lineTo(i * gridTileWidth, height);
            ctx.stroke();
            }
            i = 0;
            for(i = 0;i < verticalGridTiles;i++){
            ctx.beginPath();
            if(i / 5 == Math.round(i / 5)){
                ctx.strokeStyle = 'rgb(40,40,40)';
                ctx.lineWidth = 5;
            }else{
                ctx.strokeStyle = 'rgb(50,50,50)';
                ctx.lineWidth = 5;
            }
            ctx.moveTo(0,i * gridTileWidth);
            ctx.lineTo(width,i * gridTileWidth);
            ctx.stroke();
            }
        }

        function drawValue(value){
            ctx.clearRect(currentXvalue,0,50,height);
            if(currentXvalue > width)
            {
            currentXvalue = 0;
            }
            ctx.lineWidth = 7;
            ctx.strokeStyle = 'lime';
            var center = height / 3.3;
            ctx.moveTo(currentXvalue,center - lastYvalue);
            currentXvalue++;
            ctx.lineTo(currentXvalue,center - value);
            ctx.stroke();
            lastYvalue = value;
            // drawGrid();
            ctx.beginPath();
        }
    }


    var o2Graph = function(o2canvas){
        //init parameters

        if(typeof o2canvas == 'string'){
            o2canvas = document.getElementById(o2canvas);
        }
        o2canvas.setAttribute('width',o2canvas.offsetWidth);
        o2canvas.setAttribute('height',o2canvas.offsetHeight);

        var o2width = o2canvas.offsetWidth;
        var o2height = o2canvas.offsetHeight;
        var o2ctx = o2canvas.getContext('2d');

        var o2currentXvalue = 0;
        var o2lastYvalue = 0;

        var gridTileWidth = 20;

        //global functions

        this.getTimeInterval = function(){
            return 600 / (gridTileWidth * 2);
        }

        this.drawValueo2 = function(o2value){
            drawValueo2(o2value);
        }

        function drawValueo2(o2value){
            o2ctx.beginPath();
            o2ctx.clearRect(o2currentXvalue,0,50,o2height);
            if(o2currentXvalue > o2width)
            {
                o2currentXvalue = 0;
            }
            
            o2ctx.lineWidth = 7;
            o2ctx.strokeStyle = 'rgb(100, 172, 255)';
            var center = o2height / 1.58;
            o2ctx.moveTo(o2currentXvalue,center - o2lastYvalue);
            o2currentXvalue++;
            o2ctx.lineTo(o2currentXvalue,center - o2value);
            o2ctx.stroke();
            o2lastYvalue = o2value;
            
        }
    }

    var graphInstance = new Graph('canvas');
    var o2graphInstance = new o2Graph('o2canvas');

    var index = 0;
    var o2index = 0;
    var intervalid1 = setInterval(function(){
        if(rhythm === vFib){
            vFib = [vFib[vFib.length - 1]];
            for(var i = 0;i < 120;i++){
                var adjust = Math.random() * 4;
                if(vFib[i] > 50){
                    adjust *= Math.abs(adjust) * -1;
                }else if(vFib[i] < -50){
                    adjust = Math.abs(adjust)
                }else{
                    adjust = adjust * (Math.random() > 0.5 ? 1 : -1);
                }
                vFib[i + 1] = vFib[i] + adjust;
            }
            rhythm = vFib;
        }
    },1500);

    var beatsThisMinute = 0;
    var torsadesScale = 0.2;
    var theta = 0;

    var intervalid3 = setInterval(() => {
    theta += 0.1;
    torsadesScale = Math.sin(theta);
    },100);


    var intervalid2 = setInterval(function(){
        if(index >= rhythm.length){
            graphInstance.drawValue((Math.random() * 6));
            
        }else{
            graphInstance.drawValue(rhythm[index] * 2 * (torsades ? torsadesScale : 0.8) + (Math.random() * 2));
            if(rhythm[index] > 30){
                if (rhythm === nsr || rhythm === vTach) {
                    $.post("https://osp_ambulance/beat", JSON.stringify({coordx : posx, coordy : posy, coordz : posz}))
                }
            }
        }
        index++;
        if(index > rhythm.length){
            setTimeout(function(){
                index = 0;
            },rhythm !== vTach && rhythm !== vFib ? (Math.random() * 100 + (30000/pulse)) : 0);
        }

    },graphInstance.getTimeInterval());

    var intervalid3 = setInterval(function(){
        if(o2index >= o2rhythm.length){
            o2graphInstance.drawValueo2((Math.random() * 6));
        }else{
            o2graphInstance.drawValueo2(o2rhythm[o2index] * 2 * (oxygenSaturation/150) + (Math.random() * 2));
        }
        o2index++;
        if(o2index > o2rhythm.length){
            setTimeout(function(){
                o2index = 0;
            },(Math.random() * 100 + 150));
        }

    },o2graphInstance.getTimeInterval());



}, 500);
