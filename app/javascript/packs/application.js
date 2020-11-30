// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// 👇🏻Step 4: Importing boostrap in application.js
import 'bootstrap'

// Step 6 : wirring application.scss with application.js
import '../stylesheets/application.scss'
// Step 7: Wirring it question.js with application.js
import './question'

import "./selectize"
window.jQuery=$;
window.$=$;

console.log('Hello from app/javascript/packs/application.js')

//Ends
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
