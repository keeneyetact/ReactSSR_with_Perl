var React = require('react');

var CommentBox = require('./component/comment-box');

global.render = function (initialState) {
    return React.renderToString(React.createElement(CommentBox, {pollInterval: 2000, initialState: initialState}));
}

