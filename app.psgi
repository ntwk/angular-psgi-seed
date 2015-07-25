#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use lib './lib';
use Plack::Builder;
use Plack::Response;
use Text::Xslate;
use Encode qw(encode_utf8);

my $spa = sub {
    my ( $root, $base ) = @_;
    builder {
        enable 'Head';
        enable 'ConditionalGET';
        enable 'HTTPExceptions';
        enable 'Static', path => sub{1}, root => $root, pass_through => 1;
        enable_if { $_[0]->{PATH_INFO} } sub {
            my $app = shift;
            sub {
                my $env = shift;
                my $tx = Text::Xslate->new( path => $root );
                my $res = Plack::Response->new( 200, [content_type => 'text/html;charset=utf-8'] );
                $res->body( encode_utf8( $tx->render('index.html', { base => $base }) ) );
                return $res->finalize;
            };
        };
        sub { [ 301, [ Location => $base ], [] ] };
    };
};

builder {
    enable 'ReverseProxy';
    enable 'ErrorDocument';
    mount '/'     => $spa->('./', '/');
};
