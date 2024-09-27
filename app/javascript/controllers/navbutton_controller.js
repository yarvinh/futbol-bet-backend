import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  open(){
    const navBarList = document.getElementById("nav-bar-list");
    const lines = document.getElementById("lines-wrapper")
    const xImg = document.getElementById("nav-bar-x")
    if(navBarList.className.includes("hide")){
        navBarList.className = "nav-bar-list display"
        xImg.className = "display"
        lines.className = "display hide"
    }else{
       navBarList.className = "nav-bar-list hide"
       xImg.className = "display hide"
       lines.className = "display-lines"
    }
  }
}
