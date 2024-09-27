import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hide(event){ 
    const navBarList = document.getElementById("nav-bar-list");
    const lines = document.getElementById("lines-wrapper")
    const xImg = document.getElementById("nav-bar-x")

    if(!event.target.className.includes("display")){
      navBarList.className = "nav-bar-list hide"
      xImg.className = "display hide"
      lines.className = "display-lines"
    }
  }
}
