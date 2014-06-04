use inc::Module::Install;
name 'TVRage-Client';
all_from 'lib/TVRage/Client.pm';

requires 'Moose';
requires 'Web::Scraper' => '0.37';
requires 'Path::Class';
requires 'Moose::Role';
requires 'URI';
requires 'Carp';
requires 'DateTime::Format::ISO8601';
requires 'MooseX::Aliases';
requires 'MooseX::Storage';
requires 'MooseX::Types';
requires 'MooseX::Iterator';
requires 'MooseX::StrictConstructor' => '0.19';
requires 'namespace::autoclean';
requires 'LWP::UserAgent';
requires 'JSON::XS';
requires 'Data::Walk';
requires 'DateTime::Format::Strptime';
requires 'DateTime::Format::Atom';
requires 'DateTime::Format::DateParse';
requires 'Text::Unaccent';
requires 'Set::Scalar';
requires 'aliased';
requires 'Try::Tiny';
requires 'DateTime::Duration';
requires 'List::MoreUtils';
requires 'HTML::Strip';
requires 'Clone';

tests 't/*.t';

test_requires 'Test::More';
WriteAll;
