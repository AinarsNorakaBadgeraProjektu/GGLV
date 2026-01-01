
$(document).ready(function() {
    $.post("https://osp_ambulance/pageLoaded", JSON.stringify({}))
})

var torsades = false;
var asystole = []; 
var vTach = [0,2,5,8,10,12,15,18,20,28,30,33,40,42,46,42,35,30,20,15,10,5];
var vFib = [0];
var nsr = [0,0,0,0,0,0,0,5,10,14,16,17,16,14,10,7,5,4,3,2,1,0,-2,-4,-6,10,45,20,10,0,0,0,-5,0,0,0,5,6,7,8,9,9,9,8,7,6,5,4];
var rhythm = asystole;

var active = true;
var BodyList = [];

var posx;
var posy;
var posz;


window.addEventListener("message", function(ev) {
    const data = ev.data;
    // console.log(data.coordsx, data.coordsy, data.coordsz, data.rythm)

    posx = data.coordsx;
    posy = data.coordsy;
    posz = data.coordsz;

    BodyList = JSON.parse(data.BodyData);

    var bpm = document.querySelector(".value1");
    bpm.innerHTML = Math.round(BodyList.Pulse / 1) * 1;

    var bp = document.querySelector(".value2");
    bp.innerHTML = Math.round(BodyList.BloodPressure[0] / 1) * 1 +"/"+Math.round(BodyList.BloodPressure[1] / 1) * 1;

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
    } else if (data.rythm == 'vTach') {
        changevTach();
    } else if (data.rythm == 'torsades') {
        changetorsades();
    } else if (data.rythm == 'vFib') {
        changevFib();
    } else if (data.rythm == 'asystole') {
        changeasytole();
    }

    if (data.replace === true) {
        clear();
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
        canvas.style.backgroundColor = 'rgb(25,25,25)';

        //variables
        var width = canvas.offsetWidth;
        var height = canvas.offsetHeight;
        var ctx = canvas.getContext('2d');
        var gridTileWidth = 30;
        var currentXvalue = 0;
        var lastYvalue = 0;

        //global functions

        this.drawValue = function(value){
            drawValue(value);
        }

        this.getTimeInterval = function(){
            return 600 / (gridTileWidth * 1);
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
                ctx.lineWidth = 2;
            }else{
                ctx.strokeStyle = 'rgb(40,40,40)';
                ctx.lineWidth = 1;
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
                ctx.lineWidth = 2;
            }else{
                ctx.strokeStyle = 'rgb(50,50,50)';
                ctx.lineWidth = 1;
            }
            ctx.moveTo(0,i * gridTileWidth);
            ctx.lineTo(width,i * gridTileWidth);
            ctx.stroke();
            }
        }

        function drawValue(value){
            ctx.clearRect(currentXvalue,0,60,height);
            if(currentXvalue > width)
            {
            currentXvalue = 0;
            }
            ctx.lineWidth = 5;
            ctx.strokeStyle = 'lime';
            var center = height / 1.4;
            ctx.moveTo(currentXvalue,center - lastYvalue);
            currentXvalue++;
            ctx.lineTo(currentXvalue,center - value);
            ctx.stroke();
            lastYvalue = value;
            drawGrid();
        }
    }

    var graphInstance = new Graph('canvas');

    var index = 0;
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

    // var nsr = [0,0,0,0,0,0,0,5,10,14,16,17,16,14,10,7,5,4,3,2,1,0,-2,-4,-6,10,56,20,10,0,0,0,-5,0,0,0,5,6,7,8,9,9,9,8,7,6,5,4];
    // var rhythm = nsr;
    var beatsThisMinute = 0;
    var torsadesScale = 0.2;
    var theta = 0;

    var intervalid3 = setInterval(() => {
    theta += 0.1;
    torsadesScale = Math.sin(theta);
    },100);


    var intervalid2 = setInterval(function(){
        if(index >= rhythm.length){
            graphInstance.drawValue((Math.random() * 4));
        }else{
            if(rhythm[index] > 35){
                if (rhythm === nsr || rhythm === vTach) {
                    var context = new (window.AudioContext || window.webkitAudioContext)();
                    $.post("https://osp_ambulance/beat", JSON.stringify({coordx : posx, coordy : posy, coordz : posz}))
                    beatsThisMinute++;
                } 
            }
        graphInstance.drawValue(rhythm[index] * 2 * (torsades ? torsadesScale : 0.7) + (Math.random() * 2));
    }
    index++;
    if(index > rhythm.length){
        setTimeout(function(){
            index = 0;
        },rhythm !== vTach && rhythm !== vFib ? (Math.random() * 100 + (30000/BodyList.Pulse)) : 0);
        
    }
    },graphInstance.getTimeInterval());




    function stop() {
        clearInterval(intervalid2);
        return setInterval(function() {console.log("stopped");}, 1000);
    }
    
    function clear(){
        clearInterval(intervalid2);
        clearInterval(intervalid1);
        clearInterval(intervalid3);
    }




}, 500);



fetch(`https:/osp_ambulance/duiIsReady`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({ok: true})
})

