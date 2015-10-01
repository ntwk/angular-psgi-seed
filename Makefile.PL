#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'AngularPSGISeed',
    AUTHOR              => q{ntwk <rnndxb@gmail.com>},
    VERSION             => '0.01',
    PL_FILES            => {},
    PREREQ_PM           => {
        'Starman'                         => 0,
        'Plack'                           => 0,
        'Plack::Middleware::ReverseProxy' => 0,
        'Text::Xslate'                    => 0,
    },
);
