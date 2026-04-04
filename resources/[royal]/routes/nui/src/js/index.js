const resourceName = (typeof GetParentResourceName === "function") ? GetParentResourceName() : "routes";
const imagesUrl = "nui://vrp/config/inventory/";

const Routes = {
    load: function(title, items) {
      $(".craft-items").html("");
      $.each(items, function(index, element) {
          $(".craft-items").append(`
           <div class="item list-item"> 
              <div class="item-photo" style=" -webkit-mask-image: linear-gradient(to left, transparent 25%, black 100%);"><img src="${imagesUrl + (element.image ? element.image : index)}.png"></div>
              <div class="item-desc">
                <small>Item</small>
                <span>${element.name}</span>
              </div>
              <p>Rotas</p>
              <button onclick="Routes.selectRoute('${index}')"><i class="fas fa-play-circle icon"></i> iniciar</button>
          </div>
      `);
      });
    },
    selectRoute: function(code) {
      Routes.callServer("selectRoute", { code });
    },
    callServer: function(endpoint, data, callback) {
      $.post(`https://${resourceName}/${endpoint}`, JSON.stringify(data), callback);
    },
    close: function() {
      Routes.callServer("exit", {});
    }
};

document.addEventListener("keyup", function(event) {
  if (event.key === "Escape") {
    Routes.close();
  }
});

$(document).on("click", ".close", function() {
  Routes.close();
});
    
window.addEventListener("message", function(event) {
    var action = event.data.action;
    switch(action) {
      case "open":
        Routes.load(event.data.title, event.data.items || []);
        $("body").show();
      break;
      case "exit":
        $("body").hide();
      break;
    }
});