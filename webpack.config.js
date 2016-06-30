'use strict';

let path = require('path');
const webpack = require('webpack');

const PATHS = {
  source: path.resolve(__dirname, 'app/assets'),
  build: path.resolve(__dirname, 'public/js'),
};


const PROD = process.env.NODE_ENV == 'production';
const DEV = process.env.NODE_ENV !== 'production';
console.log("production ? " + PROD)

const CopyWebpackPlugin = require('copy-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const AssetsPlugin = require('assets-webpack-plugin');
let assetsHash = new AssetsPlugin({filename: 'assets.json', path: PATHS.build});

var uglify = new webpack.optimize.UglifyJsPlugin({minimize: true})

module.exports = {
//  context: __dirname + '/app/assets',
  entry: {
    main: 'javascripts/application.js',
  },
  output: {
    filename: PROD ? '[name].[hash].min.js' : '[name].[hash].js',
    path: PATHS.build,
    publicPath: '/js/',
  },

//  devServer: {
//    contentBase: PATHS.build,
//    },

  // The 'module' and 'loaders' options tell webpack to use loaders.
  // @see http://webpack.github.io/docs/using-loaders.html
  module: {
    loaders: [
      { test: require.resolve("jquery"), loader: "expose?$!expose?jQuery" },
      { test: /\.coffee$/, exclude: /(node_modules)/, loader: "coffee-loader" },
      { test: /\.(coffee\.md|litcoffee)$/, exclude: /(node_modules)/, loader: "coffee-loader?literate" },
      { test: /\.jsx?$/, key: 'jsx', exclude: /(node_modules)/, loader: 'babel-loader?cacheDirectory'},
      { test: /\.s(a|c)ss$/i, loader: ExtractTextPlugin.extract("css!sass")},
      { test: /\.css$/i, loader: ExtractTextPlugin.extract("css")},
      { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=8192?name=[name].[hash].[ext]" },
      { test: /\.(eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=8192?name=[name].[hash].[ext]" },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "url-loader?limit=8192?name=[name].[hash].[ext]" },
      { test: /\.(jpg|png|gif)$/, loader: 'url-loader?limit=8192?name=[name].[hash].[ext]'},
    ]
  },

  resolve: {
    modulesDirectories: ['node_modules', './src', PATHS.source],
    extensions: ['', '.js'],
  },
  plugins:  [
    (PROD ? (uglify, assetsHash) : (assetsHash)),
    new ExtractTextPlugin("[name].[hash].css", { allChunks: true }),
    new CleanWebpackPlugin(['public/js/*'], {
      verbose: true,
      dry: false
    })
  ],
  

  watchOptions: {
    aggregateTimeout: 100
  },

  devtool: PROD? '' :"source-map"
};
