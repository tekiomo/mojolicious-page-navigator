#!/usr/bin/env perl

use strict;
use warnings;

BEGIN{
  $ENV{MOJO_NO_IPV6} = $ENV{MOJO_POLL} = 1 ;
  $ENV{MOJO_APP} = undef; # 
}
use Test::More tests => 3;
use Test::Mojo;

use Mojolicious::Lite;
plugin 'page_navigator';
get( "paginator" => sub(){
    my $self = shift;
    $self->render( text => $self->page_navigator( 10, 15, { size => 'large', align => 'centered' } ) . "\n" );
  } );


my $t = Test::Mojo->new(  );
$t->get_ok( "/paginator" )
  ->status_is( 200 )
  ->content_is(<<EOF);
<div class="pagination pagination-large pagination-centered"><ul><li><a href="/paginator?page=9">&laquo;</a></li><li><a href="/paginator?page=1">1</a></li><li><a href="/paginator?page=2">2</a></li><li class="disable"><span>&hellip;</span></li><li><a href="/paginator?page=6">6</a></li><li><a href="/paginator?page=7">7</a></li><li><a href="/paginator?page=8">8</a></li><li><a href="/paginator?page=9">9</a></li><li class="active"><span>10</span><li><a href="/paginator?page=11">11</a></li><li><a href="/paginator?page=12">12</a></li><li><a href="/paginator?page=13">13</a></li><li><a href="/paginator?page=14">14</a></li><li><a href="/paginator?page=15">15</a></li><li><a href="/paginator?page=11">&raquo;</a></li></ul></div>
EOF


1;
