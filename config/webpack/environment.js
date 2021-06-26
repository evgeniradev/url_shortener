const { environment } = require('@rails/webpacker')
const webpack = require('webpack');

// import the loaders
const datatables = require('./loaders/datatables');
const jquery = require('./loaders/jquery');

// append them to webpack
environment.loaders.append('datatables', datatables);
environment.loaders.append('expose', jquery);

// https://webpack.js.org/plugins/provide-plugin/
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
  })
);

module.exports = environment
