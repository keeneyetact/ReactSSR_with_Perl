var React = require('react');

var CommentBox = require('./component/comment-box');

var initialState = JSON.parse(document.getElementById('initial-data').getAttribute('data-json'));
React.render(
  <CommentBox url="comments" pollInterval={2000} initialState={initialState} />,
  document.getElementById('content')
);
