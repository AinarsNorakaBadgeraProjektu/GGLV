var flash = false;

window.addEventListener("message", function(ev) {
    const data = ev.data;


    if (data.type == 'code') {
        $(".blue").remove();
        $(".incomingWrapper").remove();

        var input = 
        '<div class="blue">'+
            '<div class="codewrapper">'+
                '<h2>CODE BLUE</h2>'+
                '<p>' + data.room + '</p>'+
            '</div>'+
        '</div>';

        $(".wrapper").append(input);
        codeloop()

        async function codeloop() {
            while (true) {
                $(".codewrapper").hide();
                await wait(500);
                $(".codewrapper").show();
                await wait(1500);
            }
        }

    } else if (data.type == 'incoming') {
        $(".incomingWrapper").remove();
        $(".blue").remove();

        var input = 
        '<div class="incomingWrapper">'+
                '<div class="title">'+
                    '<h1 id="incoming">TERMINAL</h1>'+
                '</div>'+
                '<div class="box extraroom">'+
                    '<span class="standard">NAME:</span> <span id="name">N/A</span>'+
                    '<br>'+
                    '<span class="standard">SEX:</span> <span id="sex">N/A</span>'+
                    '<br>'+
                    '<span class="standard">AGE:</span> <span id="age">N/A</span>'+
                '</div>'+
                '<div class="box">'+
                    '<span class="standard">CONDITION:</span> <span class="condition" id="condition">N/A</span>'+
                '</div>'+
                '<div class="box">'+
                    '<span class="standard">ETA:</span> <span id="eta">N/A</span>'+
                '</div>'+
        '</div>';
        $(".wrapper").append(input);

        flash = true;
        const name = document.getElementById("name"); 
        name.innerHTML = data.name; 
        const sex = document.getElementById("sex");
        sex.innerHTML = data.sex;
        const age = document.getElementById("age");
        age.innerHTML = data.age;
        const eta = document.getElementById("eta");
        eta.innerHTML = data.eta + ' minutes';


        const condition = document.getElementById("condition");
        condition.innerHTML = data.condition;
        condition.style.color = data.color;
        const incoming = document.getElementById("incoming");
        incoming.innerHTML = "INCOMING";
        incoming.style.color = 'red';
        incloop()
        async function incloop() {
            while (flash) {
                $("#incoming").hide();
                await wait(500);
                $("#incoming").show();
                await wait(1500);
                if (flash == false){
                    break;
                };
            }
        }

    } else if (data.type == 'default') {
        $(".incomingWrapper").remove();
        $(".blue").remove();
        flash = false;

        var input = 
        '<div class="incomingWrapper">'+
                '<div class="title">'+
                    '<h1 id="incoming">TERMINAL</h1>'+
                '</div>'+
                '<div class="box extraroom">'+
                    '<span class="standard">NAME:</span> <span id="name">N/A</span>'+
                    '<br>'+
                    '<span class="standard">SEX:</span> <span id="sex">N/A</span>'+
                    '<br>'+
                    '<span class="standard">AGE:</span> <span id="age">N/A</span>'+
                '</div>'+
                '<div class="box">'+
                    '<span class="standard">CONDITION:</span> <span class="condition" id="condition">N/A</span>'+
                '</div>'+
                '<div class="box">'+
                    '<span class="standard">ETA:</span> <span id="eta">N/A</span>'+
                '</div>'+
        '</div>';

        $(".wrapper").append(input);
    };

});

function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

