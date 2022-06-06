const containerSlot = document.querySelector(".slot");
const btnConfettis = document.querySelector(".btn-confettis");
const vegetables = ["✨", "✨", "✨", "✨"];

window.onload =(fiesta);

function fiesta() {

  if(isTweening()) return;

  for (let i = 0; i < 50; i++) {
    const confetti = document.createElement("div");
    confetti.innerText = vegetables[Math.floor(Math.random() * vegetables.length)];
    containerSlot.appendChild(confetti);
  }

  animateConfettis();
}

function animateConfettis() {

  const TLCONF = gsap.timeline();

  TLCONF.to(".slot div", {
    y: "random(-100,100)",
    x: "random(-100,100)",
    z: "random(0,1000)",
    rotation: "random(-90,90)",
    duration: 1,
  })
    .to(".slot div", { autoAlpha: 0, duration: 0.3 }, "-=0.2")
    .add(() => {
      containerSlot.innerHTML = "";
    });
}

function isTweening(){
  return gsap.isTweening('.slot div');
}
