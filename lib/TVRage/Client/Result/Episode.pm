package TVRage::Client::Result::Episode;

use Moose;
use DateTime::Format::Atom;
use DateTime::Format::Strptime;
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
    isa      => 'TVRage::Client::Result::Season',
    required => 1,
);

has 'number' => (
    is       => 'ro',
    isa      => 'Str',
    builder => '_build_number',
);

has 'title' => (
    is => 'ro',
    isa => 'Str',
    lazy => 1,
    builder => '_build_title',
);

has 'thumbnails' => (
    is      => 'ro',
    lazy    => 1,
    builder => '_build_thumbnails',
);

has 'mtags' => (
    isa     => 'ArrayRef',
    is      => 'ro',
    lazy    => 1,
    builder => '_build_mtags',
);

has 'url_safe_title' => (
    is => 'ro',
    isa => 'Str',
    lazy => 1,
    builder => '_build_url_safe_title',
);

has 'id' => (
    is       => 'ro',
    isa      => 'Int',
    lazy     => 1,
    builder  =>  '_build_id',
);

sub _build_id {
    my ($self) = @_;
    return $self->season->serie->id.$self->season->number.$self->number;
}


sub _build_number {
    my ($self) = @_;
    my $ep_number = $self->data->{seasonnum}->{text};
    return $ep_number =~ s/0*(\d+)/$1/;
}

sub _build_url_safe_title {
    my ($self) = @_;
    return $self->urlify($self->title);
}

sub _build_thumbnails {
    my ($self) = @_;
    return [ 
        TVRage::Client::Result::Image->new( url=> $self->data->{screencap}->{text} ),
    ];
}

sub _build_mtags {
    my ($self) = @_;
    my $mtags = [ ];
    my $season_number = $self->season->number;
    push(@$mtags,  { term => $self->season->serie->url_safe_title.'-s'.$self->season->number} );
    push(@$mtags,  { term => $self->season->serie->url_safe_title.'-s'.$self->season->number.'-e'.$self->number} );
    push(@$mtags,  { term => $self->url_safe_title } );
    push(@$mtags,  { term => 'episodes' } );
    return $mtags;
}

sub _build_title {
    my ($self) = @_;
    return $self->data->{title}->{text};
}


sub type {
	return 'episodes';
}

=head2 published

Returns the published date as a DateTime object

=cut

sub published {
    my ($self) = @_;
    my $format = DateTime::Format::Strptime->new(
        pattern   => '%Y-%m-%d',
        time_zone => 'local',
        on_error  => 'croak',
    );
    return $format->parse_datetime($self->data->{airdate}->{text});
}


=head2 updated

Returns the updated date as a DateTime object

=cut

sub updated {
    my ($self) = @_;
    return DateTime->now;
}

sub as_hashref {
    my $self = shift;
    my %res = (
        map({$_ => $self->$_} qw/id title number/),
        published  => DateTime::Format::Atom->format_datetime($self->published),
        updated    => DateTime::Format::Atom->format_datetime($self->updated),
        thumbnails => [ {map {$_ => $self->thumbnails->[0]->$_} qw/url width height/} ],
        mtags    =>  $self->mtags,
        summary  => '',
        hits     => 0,
        duration => 0,
        type => $self->type,
        all_categories => [
                      { id => "tvguide", term => "tvguide" },
                      { id => "episodes", term => "episodes" },
        ],
        url_safe_title => $self->url_safe_title,
    );
    return \%res;
}

__PACKAGE__->meta->make_immutable;

1;

