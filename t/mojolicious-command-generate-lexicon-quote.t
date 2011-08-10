#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Copy;

use Test::More tests => 6;

use lib "$FindBin::Bin/lib";

$ENV{MOJO_APP} = 'Lexemes';

use_ok 'Mojolicious::Command::Generate::Lexicon';

my $l = new_ok 'Mojolicious::Command::Generate::Lexicon';

$l->quiet(1);

$l->run(undef, "$FindBin::Bin/templates/test-quote.html.ep");

require_ok "$FindBin::Bin/lib/Lexemes/I18N/Skeleton.pm";

# Avoid "used only once" warning
my %t = %Lexemes::I18N::Skeleton::Lexicon;

is_deeply \%Lexemes::I18N::Skeleton::Lexicon, {'Can\'t fix' => ''},
  'correct lexemes';

unlink "$FindBin::Bin/lib/Lexemes/I18N/Skeleton.pm";

# Save option test
copy(
    "$FindBin::Bin/lib/Lexemes/I18N/es.pm.quote",
    "$FindBin::Bin/lib/Lexemes/I18N/es.pm"
);

$l->run('es', "$FindBin::Bin/templates/test-quote.html.ep", '--save');

require_ok "$FindBin::Bin/lib/Lexemes/I18N/es.pm";

# Avoid "used only once" warning
%t = %Lexemes::I18N::es::Lexicon;

is_deeply \%Lexemes::I18N::es::Lexicon,
  { 'lexemes'    => 'lexemas',
    "hard\ntest" => "prueba\ndifícil",
    'Can\'t fix' => 'No puede arreglarse'
  },
  'correct lexemes';

unlink "$FindBin::Bin/lib/Lexemes/I18N/es.pm";
