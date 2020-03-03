require("chartkick")
require("chart.js")

import flatpickr from "flatpickr";
require("flatpickr/dist/themes/confetti.css");

import "bootstrap";
import { initSelect2 } from '../plugins/init_select2';

initSelect2();

document.querySelector("#rangeDate").flatpickr({
  mode: 'range',
  dateFormat: "d-m-Y",
  showMonths: 3,
  prevArrow: '<i class="far fa-hand-point-left"></i>',
  nextArrow: '<i class="far fa-hand-point-right"></i>'
});
