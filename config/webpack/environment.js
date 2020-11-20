const {
    environment
} = require('@rails/webpacker')
// Step 3:  add following configuration to this(environment.js)
const webpack = require('webpack')

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jquery: 'jquery',
        Popper: ['popper.js', 'default']
    })
)

module.exports = environment