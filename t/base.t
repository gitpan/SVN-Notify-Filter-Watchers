#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 6;

BEGIN {
  use_ok 'SVN::Notify::Filter::Watchers' or die;
}

isa_ok my $n1 = SVN::Notify->new(
       to => 'you@example.com',
       repos_path => '/foo/bar',
       revision => '42',
       filters => [ 'Watchers' ],
       ), "SVN::Notify", "Create notifyer";

isa_ok my $n2 = SVN::Notify->new(
       to => 'you@example.com',
       repos_path => '/foo/bar',
       revision   => '42',
       filters   => [ 'Watchers' ],
       watcher_property => 'svnnotify:watchers',
       skip_walking_up => 1,
       skip_deleted_paths => 1,
), "SVN::Notify", "Testing Options";

is($n2->watcher_property, 'svnnotify:watchers', "Checking setting SVN Property");
is($n2->skip_walking_up, 1, "Checking walk option");
is($n2->skip_deleted_paths, 1, "Checking deleted option");
