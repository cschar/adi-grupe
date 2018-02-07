/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// import 'rpg-awesome';
require('./maps');
console.log('Hello World from Webpacker')

document.addEventListener("turbolinks:load", function() {

    //Put this in a show.js.erb AUgh
    if(window.location.pathname.match(/grupes\/\d/)) {
        console.log("grupe detail")
        let element = document.querySelector("#single-grupe-quests-info");
        let questsinfo = JSON.parse(element.dataset.questsinfo);


        questDescriptionContainer = document.getElementById("quest-description-container")
        questBoxes = document.getElementsByClassName('quest-detail-clicker');

        for (let i = 0; i < questBoxes.length; i++) {
            let box = questBoxes[i];
            box.addEventListener("click", function (e) {
                e.preventDefault();
                questDescriptionContainer.innerHTML = questsinfo[0].body
            })
        }
    }
})

