use strict;
use warnings;
use utf8;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir( dirname(__FILE__), 'extlib', 'lib', 'perl5' );
use lib File::Spec->catdir( dirname(__FILE__), 'lib' );
use Amon2::Lite;
use JSON;

our $VERSION = '0.13';

sub load_config {
    return +{ 'DBI' => [ "dbi:SQLite:dbname=db/comment.db", '', '', ], };
}

get '/' => sub {
    my $c        = shift;
    my $comments = _get_comments( $c->dbh );
    return $c->render( 'index.tt', +{ initial_data => encode_json($comments) } );
};

get '/comments' => sub {
    my $c        = shift;
    my $comments = _get_comments( $c->dbh );
    return $c->render_json($comments);
};

post '/comments' => sub {
    my $c      = shift;
    my $author = $c->req->param('author');
    my $text   = $c->req->param('text');
    unless ( $author || $text ) {
        return $c->create_response(400);
    }
    $c->dbh->do( q{INSERT INTO comment (author, text) VALUES (?, ?)}, {}, $author, $text );
    return $c->render_json( +{ author => $author, text => $text } );
};

sub _get_comments {
    my $dbh = shift;
    return $dbh->selectall_arrayref( q{SELECT author, text FROM comment}, +{ Slice => +{} } );
}

__PACKAGE__->load_plugin('DBI');

__PACKAGE__->load_plugin('Web::JSON');

__PACKAGE__->to_app( handle_static => 1 );

__DATA__

@@ index.tt
<!DOCTYPE html>
<html>
  <head>
    <title>Hello React</title>
    <link rel="stylesheet" href="/static/css/base.css" />
  </head>
  <body>
    <div id="content"></div>
    <script id="initial-data" type="text/plain" data-json="[% $initial_data %]"></script>
    <script type="text/javascript" src="/static/js/index.js"></script>
  </body>
</html>
