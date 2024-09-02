var htmlbody = document.getElementById("root");
var navBarBtn = document.getElementById("nav-bar-btn");
var navBarList = document.getElementById("nav-bar-list");
var lines = document.getElementById("lines-wrapper")
var xImg = document.getElementById("nav-bar-x")

navBarBtn.addEventListener("click", (e) =>{
    console.log(navBarList.className,2)
    if(navBarList.className.includes("hide")){
        navBarList.className = "nav-bar-list display"
        xImg.className = "display"
        lines.className = "display hide"
    }else{
       navBarList.className = "nav-bar-list hide"
       xImg.className = "display hide"
       lines.className = "display-lines"
    }
})

htmlbody.addEventListener("click", (e) =>{
    if(!e.target.className.includes("display")){
      navBarList.className = "nav-bar-list hide"
      xImg.className = "display hide"
      lines.className = "display-lines"
    }
})
