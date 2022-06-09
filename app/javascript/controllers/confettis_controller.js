import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slot"]

  connect() {

    this.stars = ["✨", "✨", "✨", "✨"];
    this.fiesta()
  }

  fiesta() {

    if(this.isTweening()) return;

    for (let i = 0; i < 50; i++) {
      this.confetti = document.createElement("div");
      this.confetti.innerText = this.stars[Math.floor(Math.random() * this.stars.length)];
      this.slotTarget.appendChild(this.confetti);
    }

    this.animateConfettis();
  }

  animateConfettis() {

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
      this.slotTarget.innerHTML = "";
    });
  }

  isTweening() {
    return gsap.isTweening('.slot div');
  }
}
