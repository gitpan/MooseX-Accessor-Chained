
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "DEPRECATED",
  "dist_author" => [
    "Moritz Onken <onken\@netcubed.de>",
    "David McLaughlin <david\@dmclaughlin.com>"
  ],
  "dist_name" => "MooseX-Accessor-Chained",
  "dist_version" => "1.0.0",
  "license" => "perl",
  "module_name" => "MooseX::Accessor::Chained",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Moose" => 0,
    "Test::More" => "0.88",
    "Try::Tiny" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
