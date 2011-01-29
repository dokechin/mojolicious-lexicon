#!/usr/bin/env perl

use 5.008007;

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'mojoliciousx-lexemes',
    VERSION_FROM => 'lib/MojoX/I18N/Lexemes.pm',
    AUTHOR       => 'Sergey Zasenko <undef@cpan.org>',
    PREREQ_PM => { 'Mojolicious' => '1.0' },
    test => {TESTS => 't/*.t t/*/*.t t/*/*/*.t'}
);