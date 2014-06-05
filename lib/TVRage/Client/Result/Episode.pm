package TVRage::Client::Result::Episode;

use Moose;
use DateTime::Format::Atom;
use TVRage::Client::Result::Image;
use TVRage::Client::Result::Season;
use namespace::autoclean;

with 'TVRage::Client::Meta::Urlify';


has 'data' => (
    is       => 'ro',
    isa      => 'HashRef',
);

has 'season' => (
    is       => 'ro',
    isa      => 'TVRage::Client::Result::Serie',
    required => 1,
);
#
#has 'number' => (
#    is       => 'ro',
#    isa      => 'Str',
#    builder => '_build_number',
#);
#
#has 'title' => (
#    is => 'ro',
#    isa => 'Str',
#    lazy => 1,
#    builder => '_build_title',
#);
#
#has 'genres' => (
#    is => 'ro',
#    isa => 'ArrayRef',
#    lazy => 1,
#    builder => '_build_genres',
#);
#
#has 'thumbnails' => (
#    is      => 'ro',
#    lazy    => 1,
#    builder => '_build_thumbnails',
#);
#
#has 'mtags' => (
#    isa     => 'ArrayRef',
#    is      => 'ro',
#    lazy    => 1,
#    builder => '_build_mtags',
#);
#
#has 'url_safe_title' => (
#    is => 'ro',
#    isa => 'Str',
#    lazy => 1,
#    builder => '_build_url_safe_title',
#);
#
#sub _build_url_safe_title {
#    my ($self) = @_;
#    return $self->urlify($self->title);
#}
#
#sub _build_thumbnails {
#    my ($self) = @_;
#    return [ 
#        TVRage::Client::Result::Image->new( url=> $self->data->{image}->{text} ),
#    ];
#}
#
#sub _build_mtags {
#    my ($self) = @_;
#    my $mtags = [ ];
#    
#    push(@$mtags,  { term => "series-id-".$self->id } );
#    push(@$mtags,  { term => $self->url_safe_title } );
#    push(@$mtags,  { term => "series-".$self->url_safe_title } );
#    foreach my $genre ( @{$self->genres} ) {
#    	push(@$mtags,  { term => $genre } );
#    } 
#    return $mtags;
#}
#
#sub _build_number {
#    my $self = shift;
#    return $self->client->full_series_data( $self->id )->{Show};
#}
#
#sub _build_season_number {
#    my $self = shift;
#    return $self->client->full_series_data( $self->id )->{Show};
#}
#
#sub _build_title {
#    my ($self) = @_;
#    return $self->data->{name}->{text};
#}
#
#sub _build_genres {
#    my ($self) = @_;
#    my $genres = [];
#    foreach my $genre ( @{$self->data->{genres}->{genre}} ) {
#    	push @$genres, $genre->{text};
#    }
#    return $genres;
#}
#
#sub type {
#	return 'series';
#}
#
#=head2 published
#
#Returns the published date as a DateTime object
#
#=cut
#
#sub published {
#    my ($self) = @_;
#    return DateTime->now;
#}
#
#
#=head2 updated
#
#Returns the updated date as a DateTime object
#
#=cut
#
#sub updated {
#    my ($self) = @_;
#    return DateTime->now;
#}
#
#sub as_hashref {
#    my $self = shift;
#    my %res = (
#        map({$_ => $self->$_} qw/id title/),
#        published  => DateTime::Format::Atom->format_datetime($self->published),
#        updated    => DateTime::Format::Atom->format_datetime($self->updated),
#        thumbnails => [ {map {$_ => $self->thumbnails->[0]->$_} qw/url width height/} ],
#        mtags    =>  $self->mtags,
#        hits     => 0,
#        duration => 0,
#        type => $self->type,
#        url_safe_title => $self->url_safe_title,
#    );
#    return \%res;
#}

__PACKAGE__->meta->make_immutable;

1;

