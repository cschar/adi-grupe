

//TODO put this in a show.js.erb
// document.addEventListener("turbolinks:load", function() {

//     console.log("grupe detail turbolinks loaded")
//     let element = document.querySelector("#single-grupe-quests-info");
//     let questsinfo = JSON.parse(element.dataset.questsinfo);


//     questDescriptionContainer = document.getElementById("quest-description-container")
//     questBoxes = document.getElementsByClassName('quest-detail-clicker');

//     for (let i = 0; i < questBoxes.length; i++) {
//         let box = questBoxes[i];
//         box.addEventListener("mouseover", function (e) {
//             e.preventDefault();
//             htmlInsert = `
//             <div>
//             <i class="fa fa-map-o fa-2x"></i> : blocks ${Math.random() * (10)} blocks
//             <br/>
//             <i class="fa fa-map-o fa-2x"></i> : Stat 2 : ${Math.random() * (10)}
//             <br/>
//             <i class="fa fa-map-o fa-2x"></i> : stat 3 : ${Math.random() * (100)}
//             <br/>
//             Extended Description (scroll box here):
//                 ${questsinfo[i].body}
//             </div>
//             `
//             questDescriptionContainer.innerHTML = htmlInsert
//         })
//     }

// })
