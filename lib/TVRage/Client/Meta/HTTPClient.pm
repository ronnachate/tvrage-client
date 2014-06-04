package TVRage::Client::Meta::HTTPClient;

use Moose::Role;

use URI;
use LWP::UserAgent;
use CHI;
use Moose::Util::TypeConstraints;
use Carp qw/croak/;
use namespace::autoclean;

subtype 'TVRage::Client::Types::Cache',
    => as 'Object';

coerce 'TVRage::Client::Types::Cache',
    => from 'HashRef',
    => via { CHI->new(%$_) };

subtype 'TVRage::Client::Types::UA',
    => as 'LWP::UserAgent';

coerce 'TVRage::Client::Types::UA',
    => from 'HashRef',
    => via { LWP::UserAgent->new(%$_) };

has cache => (
    is      => 'rw',
    isa     => 'TVRage::Client::Types::Cache',
    coerce  => 1,
    lazy    => 1,
    builder => '_build_cache',
);

has use_cache => (
    is      => 'rw',
    isa     => 'Bool',
    default => 1,
);

has 'ua' => (
    is      => 'ro',
    isa     => 'LWP::UserAgent',
    builder => '_build_ua',
);


sub _build_ua {
    return LWP::UserAgent->new( timeout => 15 );
}

sub _build_cache {
    return CHI->new(
        driver     => 'File',
        expires_in => '60s',
    );
}

=head2 fetch $uri, \%args
    Returns cached and non-expired content if existing, or tries to fetch new content.
    Falls back to expired cache if fetching new content fails
=cut


sub fetch {
    my ($self, $uri, $opts) = @_;
#warn $uri;
    my $cache_obj = $self->get_cache_object("$uri");

    if ($self->use_cache) {
        if (defined $cache_obj && !$cache_obj->is_expired) {
            return $cache_obj->value();
        }
    }

    my $res = $self->ua->get($uri);
    if ($res->is_success) {
        my $content = $res->decoded_content;
        $self->set_cache("$uri", $content, $opts) if $self->use_cache;
        return $content;
    }
    else {
        if ($self->use_cache && defined $cache_obj) {
            return $cache_obj->value();
        }
        else {
            croak("error fetching '$uri': " . $res->status_line);
        }
    }
}


=head2 set_cache $req, $res, $opts

=cut

sub set_cache {
    my ($self, $uri, $content, $opts) = @_;
    $self->cache->set($self->_make_cache_key($uri), $content, $opts);
}

=head2 get_cache $req

=cut

sub get_cache {
    my ($self, $uri) = @_;
    $self->cache->get($self->_make_cache_key($uri));
}

=head2 get_cache_object $req

=cut

sub get_cache_object {
    my ($self, $uri) = @_;
    $self->cache->get_object($self->_make_cache_key($uri));
}

=head2 remove cache $req

=cut

sub remove_cache {
    my ($self, $uri) = @_;
    $self->cache->remove($self->_make_cache_key($uri));
}

=head2 _make_cache_key $uri

=cut

sub _make_cache_key {
    my ($self, $uri) = @_;
    $uri = URI->new($uri) unless ref $uri eq 'URI';
    my %params = $uri->query_form;
    my $key = $uri->can('host_port') ? $uri->host_port . $uri->path : $uri->path;
    return $key . join "&", map { "$_=$params{$_}" } sort keys %params;
}

1;

