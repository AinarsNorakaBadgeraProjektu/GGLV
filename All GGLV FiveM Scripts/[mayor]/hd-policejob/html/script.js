import { GameView } from './gameview.js';
const gameview = new GameView();
var translations = {}
var canclose = false
var officer = false
var tempdata = null
var gpsstatus = false
var isdown = false
var BCRecording = false
let mediaRecorder
let audioStream
var currentTime
let selectedVehicle = null;
let selectedVehicleData = null;
const canvasElement = document.querySelector('canvas')

function loadTranslations() {
  $.getJSON(`../locales/ui.json`, function(data) {
      translations = data;
  });
}

function translate(textKey) {
  if (translations && translations[textKey]) {
      return translations[textKey];
  } else {
      return textKey;
  }
}

function getDateTime(option) {
    var now     = new Date(); 
    var year    = now.getFullYear();
    var month   = now.getMonth()+1;
    var day     = now.getDate();
    var hour    = now.getHours();
    var minute  = now.getMinutes();
    var second  = now.getSeconds();
    if(month.toString().length == 1) { month = '0'+month;}
    if(day.toString().length == 1) {day = '0'+day;}
    if(hour.toString().length == 1) {hour = '0'+hour;}
    if(minute.toString().length == 1) {minute = '0'+minute;}
    if(second.toString().length == 1) {second = '0'+second;}
    if(option === 'datetime'){
        var dateTime = day+'-'+month+'-'+year+' '+hour+':'+minute+':'+second;
    } else if (option === 'time'){
        var dateTime = hour+':'+minute;
    }
    return dateTime;
}

const CameraApp = new Vue({
    el: "#camcontainer",

    data: {
        camerasOpen: false,
        cameraLabel: ":)",
        connectLabel: "CONNECTED",
        ipLabel: "192.168.0.1",
        dateLabel: "04/09/1999",
        timeLabel: "16:27:49",
    },

    methods: {
        OpenCameras(label, connected, cameraId, time) {
            var today = new Date();
            var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
            var formatTime = "00:" + time

            this.camerasOpen = true;
            this.ipLabel = "145.101.0."+cameraId;
            if (connected) {
                $("#blockscreen").css("display", "none");
                this.cameraLabel = label;
                this.connectLabel = "CONNECTED";
                this.dateLabel = date;
                this.timeLabel = formatTime;

                $("#connectedlabel").removeClass("disconnect");
                $("#connectedlabel").addClass("connect");
            } else {
                $("#blockscreen").css("display", "block");
                this.cameraLabel = "ERROR #400: BAD REQUEST"
                this.connectLabel = "CONNECTION FAILED";
                this.dateLabel = "ERROR";
                this.timeLabel = "ERROR";

                $("#connectedlabel").removeClass("connect");
                $("#connectedlabel").addClass("disconnect");
            }
            
        },

        CloseCameras() {
            this.camerasOpen = false;
            $("#blockscreen").css("display", "none");
        },

        UpdateCameraLabel(label) {
            this.cameraLabel = label;
        },

        UpdateCameraTime(time) {
            var formatTime = "00:" + time
            this.timeLabel = formatTime;
        },
    }
});

var HeliCam = {}
var Databank = {}
var Fingerprint = {}
var Alcoholtester = {}
var GPSitem = {}
var FPScanner = {}
var BodyCam = {}
var Garage = {}
var FPOpen = false
var UsedFPButton = false

HeliCam.Open = function(data) {
    $("#helicontainer").css("display", "block");
    $(".scanBar").css("height", "0%");
}

HeliCam.UpdateScan = function(data) {
    $(".scanBar").css("height", data.scanvalue +"%");
}

HeliCam.UpdateVehicleInfo = function(data) {
    $(".vehicleinfo").css("display", "block");
    $(".scanBar").css("height", "100%");
    $(".heli-model").find("p").html("MODEL: " + data.model);
    $(".heli-plate").find("p").html("PLATE: " + data.plate);
    $(".heli-street").find("p").html(data.street);
    $(".heli-speed").find("p").html(data.speed + " KM/U");
}

HeliCam.DisableVehicleInfo = function() {
    $(".vehicleinfo").css("display", "none");
}

HeliCam.Close = function() {
    $("#helicontainer").css("display", "none");
    $(".vehicleinfo").css("display", "none");
    $(".scanBar").css("height", "0%");
}

Databank.Open = function() {
    $(".databank-container").css("display", "block").css("user-select", "none");
    $(".databank-container iframe").css("display", "block");
    $(".tablet-frame").css("display", "block").css("user-select", "none");
    $(".databank-bg").css("display", "block");
}

Databank.Close = function() {
    $(".databank-container iframe").css("display", "none");
    $(".databank-container").css("display", "none");
    $(".tablet-frame").css("display", "none");
    $(".databank-bg").css("display", "none");
    $.post("https://hd-policejob/closeDatabank", JSON.stringify({}));
}

Fingerprint.Open = function() {
    $(".fingerprint-container").fadeIn(150);
    $(".fingerprint-id").html("");
}

Alcoholtester.Open = function(user) {
    if (user) {
        $(".take-alcoholtester").css("display", "none")
        $('.blaaspijp').css('display', 'block')
        $(".alcoholtester-id").html("<div><p>BLOW</p></div>");
    } else {
        $(".blaaspijp").css("display", "none")
        $(".take-alcoholtester").css("display", "block")
        $(".alcoholtester-id").html("<div><p>PRESS POWER</p></div>");
    }
}

Fingerprint.Close = function() {
    $(".fingerprint-container").fadeOut(150);
    $.post('https://hd-policejob/closeFingerprint');
}

Alcoholtester.Close = function() {
    $(".alcoholtester-container").fadeOut(150);
    $.post('https://hd-policejob/closeAlcoholtester');
}

Fingerprint.Update = function(data) {
    $(".fingerprint-id").html("<div class='fingerprint-screen'><img src="+data.Headshot+"></img><div class='line'></div><p style='padding-top:6vh'>Name:<br><b>"+data.Name+"</b></p><p>Fingerprint id:<br><b>"+data.Fingerprint+"</b></p><p>Citizenid:<br><b>"+data.Citizenid+"</b></p></div>");
}

Alcoholtester.Update = function(promille) {
    $(".alcoholtester-id").html("<div><p>ANALYZING</p></div>");
    setTimeout(function() {
        $(".alcoholtester-id").html("<div><p>RESULT</p><p>"+promille+"</p></div>");
        setTimeout(function(){
            Alcoholtester.Close();
        }, 6000);
    }, 6000);
}

// FINGERPRINT SCANNER 

FPScanner.Open = function() {
    officer = true
    $('.scaner').css('display', 'block')
    $('.scanner-text').html(translate("scanner"))
}

FPScanner.OpenOther = function() {
    $('.scaner').css('display', 'block')
    FPOpen = true
    $('.close-button').css('color', '#63E10E')
    $('.close-button').css('border', '0.15vw solid #63E10E')
    $('.second-screen').css('display', 'block')
    $('.scanner-text-2').html(translate("scan_finger"))
    $('#second-info').html(translate("puton_plate"))
    $('.fingerprint').css('display', 'block')
}

FPScanner.Close = function() {
    if (canclose) {
        FPOpen = false
        UsedFPButton = false
        officer = false
        tempdata = null
        canclose = false
        $('.scaner').css('display', 'none')
        $('.scanner-text-2').html('')
        $('.close-button').css('color', '#E31718')
        $('.close-button').css('border', '0.15vw solid #E31718')
        $('.first-screen').css('display', 'none')
        $('.second-screen').css('display', 'none')
        $('.fingerprint').css('display', 'none')
        $('.finish-screen').css('display', 'none')
        $(".user-photo").attr("src", "./images/user2.png");
        $.post('https://hd-policejob/closeFPScanner');
    }
}

FPScanner.DoFingerScanAnim = function() {
    var styleElem = document.head.appendChild(document.createElement("style"));
    styleElem.innerHTML = ".fp-scan .fingerprint::before {display: block;}";
    var styleElem = document.head.appendChild(document.createElement("style"));
    styleElem.innerHTML = ".fp-scan .fingerprint::after {display: block;}";
}

FPScanner.StopFingerScanAnim = function() {
    var styleElem = document.head.appendChild(document.createElement("style"));
    styleElem.innerHTML = ".fp-scan .fingerprint::before {display: none;}";
    var styleElem = document.head.appendChild(document.createElement("style"));
    styleElem.innerHTML = ".fp-scan .fingerprint::after {display: none;}";
}

FPScanner.UpdateFSData = function(data, img){
    $('.fingerprint').css('display', 'block')
    UsedFPButton = true
    FPScanner.DoFingerScanAnim()
    $('.scanner-text-2').html(translate("scanning"))
    setTimeout(() => {
        FPScanner.StopFingerScanAnim()
        $('.scanner-text-2').html(translate("analyzing"))
        setTimeout(() => {
            canclose = true
            $('.second-screen').css('display', 'none')
            $('.finish-screen').css('display', 'block')
            $('.scanner-title').html(translate("fscan_title"))
            $(".user-photo").attr("src", img);
            $('#cid').html(translate("cid") +'<span class="info-comment"> ' +data.citizen+'</span>')
            $('#name').html(translate("name") +'<span class="info-comment"> ' +data.name+'</span>')
            $('#dob').html(translate("dob") +'<span class="info-comment"> ' +data.dob+'</span>')
            $('#country').html(translate("country") +'<span class="info-comment"> ' +data.nation+'</span>')
            $('#gender').html(translate("gender") +'<span class="info-comment"> ' +data.gender+'</span>')
            $('#fid').html(translate("fid") +'<span class="info-comment" id="finger-id"> ' +data.id+'</span>')
            $('#copy-fid').html(translate("copy_fid"))
            $('#print-info').html(translate("print_info"))
            $('#remove-info').html(translate("remove_info"))
            if (!officer){
                $('.button-list').css('display', 'none')
            } else {
                $('.button-list').css('display', 'flex')
            }
        }, 2000);
    }, 5000);
}

$(document).on('click', '.close-button', function(){
    if (FPOpen){
        if (canclose){
            FPOpen = false
            FPScanner.Close()
        }
    } else {
        FPOpen = true
        $('.close-button').css('color', '#63E10E')
        $('.close-button').css('border', '0.15vw solid #63E10E')
        $('.first-screen').css('display', 'block')
        $('#load').html(translate("starting"))
        setTimeout(function(){
            $('#load').html(translate("running"))
            $('.scanner-text-2').html(translate("wait_input"))
            setTimeout(function(){
                $('.first-screen').css('display', 'none')
                $('.second-screen').css('display', 'block')
                $('.scanner-title').html(translate("sscan_title"))
                $('#second-info').html(translate("wait_scan"))
                $.post('https://hd-policejob/StartFingerScan')
            }, 2000);
        }, 5000);
    }
})

$(document).on('click', '.fingerprint', function(){
    if (!(UsedFPButton)){
        UsedFPButton = true
        $.post('https://hd-policejob/SendFingerScan');
    }
})

$(document).on('click', '#copy-fid', function(){
    var div = document.getElementById('finger-id');
    var textArea = document.createElement('textarea');
    textArea.style.opacity = 0;
    textArea.value = div.innerText;
    document.body.appendChild(textArea);
    textArea.select();
    try {
        $('#copy-fid').css('background', '#006700')
        document.execCommand('copy');
        setTimeout(function() {
            $('#copy-fid').css('background', '#FE6631')
        }, 2000);
    } catch {}
})

$(document).on('click', '#print-info', function(){
    $('#print-info').css('background', '#006700')
    setTimeout(function() {
        $('#print-info').css('background', '#FE6631')
    }, 2000);
    $.post("https://hd-policejob/printFingerData", JSON.stringify(tempdata));
})

// END FINGERPRINT SCANNER

// BODYCAM

BodyCam.UploadVideo = async function(videoBlob, hook) {
    $.post(`https://hd-policejob/exitBodyCam`, '{}');
    const formData = new FormData();
    try {
        let response, responseData;
        formData.append('file', videoBlob, 'video.webm');
        response = await fetch(hook, {
            method: 'POST',
            body: formData,
        });
        if (!response.ok) {
            throw new Error(`Failed to upload video to Discord: ${response.status}`);
        }
        responseData = await response.json();
        $.post(`https://hd-policejob/uploadVideo`, JSON.stringify({
            videourl: responseData.attachments[0].url
        }));
    } catch (error) {
        console.error('^1[ERROR]:^3', error.message);
    }
}

BodyCam.CaptureMic = async function() {
    try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        return stream;
    } catch (error) {
        console.error('No audio device found, capturing only video.');
        return null;
    }
}

BodyCam.StartRecord = async function(hook) {
    audioStream = await BodyCam.CaptureMic();
    if (!BCRecording){
        if (audioStream) { audioStream.getAudioTracks().forEach(track => track.stop()); }
        return 
    }
    console.log('Video Recording Started');
    const gameView = gameview.createGameView(canvasElement);
    const canvasStream = canvasElement.captureStream(30);

    // Combine audio and video streams
    const combinedStream = new MediaStream([
        ...canvasStream.getVideoTracks(),
        ...(audioStream ? audioStream.getAudioTracks() : [])
    ]);

    const videoChunks = [];
    window.gameView = gameView;
    mediaRecorder = new MediaRecorder(combinedStream, { mimeType: 'video/webm;codecs=vp9' });
    mediaRecorder.start();
    mediaRecorder.ondataavailable = (e) => e.data.size > 0 && videoChunks.push(e.data);
    mediaRecorder.onstop = async () => {
        const videoBlob = new Blob(videoChunks, { type: 'video/webm' });
        if (videoBlob.size > 0) { BodyCam.UploadVideo(videoBlob, hook);}
        if (audioStream) { audioStream.getAudioTracks().forEach(track => track.stop()); }
    };
}

BodyCam.StopRecord = function(){
    if (mediaRecorder && mediaRecorder.state === 'recording') {
        mediaRecorder.stop();
    }
}

// END BODYCAM

// GPS WATCH

GPSitem.Close = function() {
    $(".channel-input").css('display', 'none');
    $(".watch-sos").css('display', 'none');
    $('.watch-container').css('display', 'none');
    $('.watch-text').html('');
    $('.watch-button').html('');
    $.post("https://hd-policejob/closeGPS");
}

// END GPS WATCH

// GARAGE

Garage.getVehicleIcon= function(vehicleCategory) {
    const name = vehicleCategory.toLowerCase();
    
    if (name.includes('helicopter') || name.includes('heli')) return 'pg-icon-helicopter';
    if (name.includes('boat') || name.includes('marine')) return 'pg-icon-boat';
    if (name.includes('motorcycle') || name.includes('bike')) return 'pg-icon-motorcycle';
    if (name.includes('ambulance') || name.includes('ems')) return 'pg-icon-ambulance';
    if (name.includes('fire')) return 'pg-icon-fire';
    if (name.includes('riot') || name.includes('swat') || name.includes('van')) return 'pg-icon-van';
    if (name.includes('suv') || name.includes('k9')) return 'pg-icon-suv';
    if (name.includes('truck') || name.includes('command')) return 'pg-icon-truck';
    if (name.includes('police')) return 'pg-icon-police';
    
    return 'pg-icon-car';
}


Garage.populateVehicleList = function(vehicles) {
    const vehicleList = document.getElementById('pgVehicleList');
    vehicleList.innerHTML = '';

    vehicles.forEach(vehicle => {
        const vehicleItem = document.createElement('div');
        vehicleItem.className = 'pg-vehicle-item';
        vehicleItem.setAttribute('data-vehicle', vehicle.vehicle);
        
        vehicleItem.innerHTML = `
            <div class="pg-vehicle-icon ${Garage.getVehicleIcon(vehicle.label)}"></div>
            <div class="pg-vehicle-info">
                <div class="pg-vehicle-name">${vehicle.label}</div>
                <div class="pg-vehicle-price">${vehicle.priceText}</div>
            </div>
        `;

        vehicleItem.addEventListener('click', function() {
            document.querySelectorAll('.pg-vehicle-item').forEach(i => i.classList.remove('pg-selected'));
            this.classList.add('pg-selected');
            selectedVehicle = vehicle.vehicle;
            selectedVehicleData = vehicle;
            const spawnButton = document.getElementById('pgSpawnButton');
            spawnButton.textContent = 'SPAWN';
            spawnButton.disabled = false;

            if (typeof GetParentResourceName !== 'undefined') {
                // This is running in FiveM NUI
                fetch(`https://${GetParentResourceName()}/showVeh`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: JSON.stringify(selectedVehicleData)
                });
            } else {
                // Fallback for testing outside FiveM
                console.log('Spawning vehicle:', selectedVehicleData);
                alert(`Spawning ${selectedVehicleData.label} for ${selectedVehicleData.priceText}`);
            }
        });

        vehicleList.appendChild(vehicleItem);
    });
}

Garage.spawnVehicle = function() {
    if (!selectedVehicle || !selectedVehicleData) return;
    
    // Send data to FiveM client
    if (typeof GetParentResourceName !== 'undefined') {
        // This is running in FiveM NUI
        fetch(`https://${GetParentResourceName()}/spawnVehicle`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify(selectedVehicleData)
        });
    } else {
        // Fallback for testing outside FiveM
        console.log('Spawning vehicle:', selectedVehicleData);
        alert(`Spawning ${selectedVehicleData.label} for ${selectedVehicleData.priceText}`);
    }
};

Garage.closeGarage = function() {
    if (typeof GetParentResourceName !== 'undefined') {
        // Send close event to FiveM
        fetch(`https://${GetParentResourceName()}/closeGarage`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        });
    } else {
        // Fallback for testing
        console.log('Closing garage');
        document.querySelector('.pg-garage-container').style.display = 'none';
    }
}

$(document).on('click', '.pg-close-button', function () {
    Garage.closeGarage()
});

$(document).on('click', '.pg-spawn-button', function () {
    if (!selectedVehicle || !selectedVehicleData) return;
    Garage.spawnVehicle()
});

// END GARAGE

$(document).on('click', '.take-fingerprint', function(){
    $.post('https://hd-policejob/doFingerScan');
})

$(document).on('click', '.take-alcoholtester', function(){
    $('.take-alcoholtester').css('display', 'none')
    $(".alcoholtester-id").html("<div><p>WAITING</p></div>");
    $.post('https://hd-policejob/doAlcoholTest');
})

$(document).on('click', '.blaaspijp', function(){
    $('.blaaspijp').css('display', 'none')
    $(".alcoholtester-id").html("<div><p>BLOWING</p></div>");
    setTimeout(function() {
        $(".alcoholtester-id").html("<div><p>WAITING</p></div>");
        $.post('https://hd-policejob/startBlowing');
    }, 4000);
})

$(document).on('click', '.watch-button', function(){
    if (gpsstatus && !isdown){
        gpsstatus = false
        $('.watch-button').html(translate("activate_gps"))
        $('#satellite-icon').css('color', '#ff2b00')
    } else if (!gpsstatus && !isdown) {
        gpsstatus = true
        $('.watch-button').html(translate("deactivate_gps"))
        $('#satellite-icon').css('color', '#ff7600')
    }
    var cs = document.querySelector('#channel-input').value
    var name = document.querySelector('.watch-text').textContent
    fetch("https://hd-policejob/toggleGPS", {
        method: "POST",
        headers: {"Content-Type": "application/json; charset=UTF-8",},
        body: JSON.stringify({gpsstatus, cs, name, isdown}),
    })
        .then((response) => response.json())
        .then((data) => {
            if (data === "ok") {
                if (gpsstatus){
                    $('.watch-button').html(translate("deactivate_gps"))
                    $('#satellite-icon').css('color', '#ff7600')
                } else {
                    $('.watch-button').html(translate("activate_gps"))
                    $('#satellite-icon').css('color', '#ff2b00')
                }
            } else { console.error("Failed to toggle GPS.");}
    });
})

$(document).on('click', '.recCloseIcon', function () {
    $('.recordPlayer').css('display', 'none')
    $('.videoPlayer').attr('src', '');
    $.post('https://hd-policejob/closeVideoScreen');
});

document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        loadTranslations()
        window.addEventListener('message', function(event) {
            var data = event.data
            switch (data.type){
                case "enablecam":
                    CameraApp.OpenCameras(data.label, data.connected, data.id, data.time);
                    break;
                case "disablecam":
                    CameraApp.CloseCameras();
                    break;
                case "updatecam":
                    CameraApp.UpdateCameraLabel(data.label);
                    break;
                case "updatecamtime":
                    CameraApp.UpdateCameraTime(data.time);
                    break;
                case "heliopen":
                    HeliCam.Open(data);
                    break;
                case "heliclose":
                    HeliCam.Close();
                    break;
                case "heliscan":
                    HeliCam.UpdateScan(data);
                    break;
                case "heliupdateinfo":
                    HeliCam.UpdateVehicleInfo(data);
                    break;
                case "disablescan":
                    HeliCam.DisableVehicleInfo();
                    break;
                case "databank":
                    canclose = true
                    Databank.Open();
                    break;
                case "closedatabank":
                    Databank.Close();
                    break;
                case "fingerprintOpen":
                    canclose = true
                    Fingerprint.Open();
                    break;
                case "fingerprintClose":
                    Fingerprint.Close();
                    break;
                case "updateFingerprintId":
                    Fingerprint.Update(data);
                    break;
                case "openAlcoholTester":
                    canclose = true
                    var user = data.user
                    $(".alcoholtester-container").css("display", "block");
                    Alcoholtester.Open(user);
                    break;
                case "closeAlcoholTester":
                    Alcoholtester.Close();
                    break;
                case "updateAlcoholTester":
                    Alcoholtester.Update(data.promille);
                    break;
                case 'openFPScanner':
                    canclose = true
                    FPScanner.Open();
                    break;
                case 'openFPScannerOther':
                    FPScanner.OpenOther();
                    break;
                case 'updateFingerData':
                    var fdata = data.fdata;
                    var img = data.photo;
                    tempdata = fdata;
                    FPScanner.UpdateFSData(fdata, img);
                    break;
                case 'openBodyCamOverlay':
                    var show = data.show
                    if (show){
                        $('.overlayCont').css('display', 'flex')
                        setInterval(function(){
                            currentTime = getDateTime('datetime');
                            document.getElementById("bcdatetime").innerHTML = currentTime;
                        }, 1000);
                        $('.bodyNum').html(data.bodyname)
                        $('.bodyCallsign').html(data.callsign)
                    } else { $('.overlayCont').css('display', 'none') }
                    break;
                case 'openWatchBCUI':
                    var show = data.show
                    if (show) {
                        $('.currWatchCont').css('display', 'flex')
                        document.querySelector('.typeCam').textContent = "BODYCAM";
                        document.querySelector('.plateText').textContent = "CamID: " + data.bodyId;
                        document.querySelector('.carText').textContent = "Name: " + data.name;
                    } else { $('.currWatchCont').css('display', 'none') }
                    break;
                case 'recordBodycam':
                    clearTimeout(recTimeout);
                    if (!BCRecording) {
                        BCRecording = true
                        BodyCam.StartRecord(data.hook);
                        var recTimeout = setTimeout(() => {
                            if (BCRecording) {
                                BCRecording = false;
                                BodyCam.StopRecord()
                            }
                        }, data.rectime * 1000)
                    } else {
                        BCRecording = false
                        clearTimeout(recTimeout)
                        BodyCam.StopRecord()
                    }
                    break;
                case 'openrecordPlayer':
                    $('.recordPlayer').css('display', 'flex')
                    $('.videoPlayer').attr('src', data.url)
                    break;
                case "openGPSWatch":
                    canclose = true
                    $('.watch-container').css('display', 'block')
                    $('.watch-text').html(data.name)
                    if (data.status) {
                        $('#channel-input').css('display', 'none')
                        $('.watch-sos').css('display', 'block')
                        $('.watch-button').html(translate("send_sos"))
                        isdown = true
                    } else {
                        isdown = false
                        $('#channel-input').css('display', 'block')
                        document.querySelector('#channel-input').value = data.cs
                        if (!data.state){ 
                            $('.watch-button').html(translate("activate_gps"))
                            $('#satellite-icon').css('color', '#ff2b00')
                            gpsstatus = false
                        } else { 
                            $('.watch-button').html(translate("deactivate_gps"))
                            $('#satellite-icon').css('color', '#ff7600')
                            gpsstatus = true
                        }
                    }
                    setInterval(function(){
                        currentTime = getDateTime('time');
                        document.getElementById("watch").innerHTML = currentTime;
                    }, 1000);
                    break;
                case "cancel_rec_force":
                    if (BCRecording) {
                        // Force stop recording
                        BCRecording = false;
                        clearTimeout(recTimeout);
                        stopRecording();
                    }
                    break;
                case "openGarage":
                    if (data.title) {
                        document.querySelector('.pg-garage-title').textContent = data.title;
                    }
                    if (data.vehicles) {
                        Garage.populateVehicleList(data.vehicles);
                    }
                    selectedVehicle = null;
                    selectedVehicleData = null;
                    document.getElementById('pgSpawnButton').textContent = 'Select a Vehicle';
                    document.getElementById('pgSpawnButton').disabled = true;
                    
                    // Show garage
                    document.querySelector('.pg-garage-container').style.display = 'block';
                    break;
                case "closeGarage":
                    document.querySelector('.pg-garage-container').style.display = 'none';
                    break;
                default:
                    console.log(`Not a correct event sended. Got event ${data.type}`);
            }
        });
    };
};

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            if (canclose){
                Databank.Close();
                Fingerprint.Close();
                Alcoholtester.Close();
                FPScanner.Close();
                GPSitem.Close();
                Garage.closeGarage();
            }
            break;
    }
});
