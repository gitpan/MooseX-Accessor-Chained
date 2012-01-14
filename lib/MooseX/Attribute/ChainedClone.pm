#
# This file is part of MooseX-Accessor-Chained
#
# This software is copyright (c) 2012 by Moritz Onken.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
package MooseX::Attribute::ChainedClone;
{
  $MooseX::Attribute::ChainedClone::VERSION = '1.0.0';
}

# ABSTRACT: Accessor that returns a cloned object
use Moose::Util;
Moose::Util::meta_attribute_alias(
    ChainedClone => 'MooseX::Traits::Attribute::ChainedClone' );

package MooseX::Traits::Attribute::ChainedClone;
{
  $MooseX::Traits::Attribute::ChainedClone::VERSION = '1.0.0';
}
use Moose::Role;

override accessor_metaclass => sub {
    'MooseX::Attribute::ChainedClone::Method::Accessor';
};

package MooseX::Attribute::ChainedClone::Method::Accessor;
{
  $MooseX::Attribute::ChainedClone::Method::Accessor::VERSION = '1.0.0';
}
use Carp qw(confess);
use Try::Tiny;
use base 'Moose::Meta::Method::Accessor';

sub _generate_accessor_method_inline {
    my $self = shift;
    my $attr = $self->associated_attribute;
    my $clone
        = $attr->associated_class->has_method("clone")
        ? '$_[0]->clone'
        : 'bless { %{$_[0]} }, ref $_[0]';

    if ( $Moose::VERSION >= 1.9900 ) {
        return try {
            $self->_compile_code(
                [   'sub {',
                    'if (@_ > 1) {',
                    'my $clone = ' . $clone . ';',
                    $attr->_inline_set_value( '$clone', '$_[1]' ),
                    'return $clone;',
                    '}',
                    $attr->_inline_get_value('$_[0]'),
                    '}',
                ]
            );
        }
        catch {
            confess "Could not generate inline accessor because : $_";
        };
    }
    else {
        my ( $code, $e ) = $self->_eval_closure(
            {},
            join( "\n",
                'sub {',
                'if (@_ > 1) {',
                'my $clone = ' . $clone . ';',
                $attr->inline_set( '$clone', '$_[1]' ),
                'return $clone;',
                '}',
                $attr->inline_get('$_[0]'),
                '}' ),
        );
        confess "Could not generate inline predicate because : $e" if $e;
        return $code;
    }
}

sub _generate_writer_method_inline {
    my $self = shift;
    my $attr = $self->associated_attribute;
    my $clone
        = $attr->associated_class->has_method("clone")
        ? '$_[0]->clone'
        : 'bless { %{$_[0]} }, ref $_[0]';
    if ( $Moose::VERSION >= 1.9900 ) {
        return try {
            $self->_compile_code(
                [   'sub {',
                    'my $clone = ' . $clone . ';',
                    $attr->_inline_set_value( '$clone', '$_[1]' ),
                    'return $clone;', '}',
                ]
            );
        }
        catch {
            confess "Could not generate inline writer because : $_";
        };
    }
    else {
        my ( $code, $e ) = $self->_eval_closure(
            {},
            join( "\n",
                'sub {',
                'my $clone = ' . $clone . ';',
                $attr->inline_set( '$clone', '$_[1]' ),
                'return $clone;', '}' ),
        );
        confess "Could not generate inline writer because : $e" if $e;
        return $code;
    }
}

1;

__END__
=pod

=head1 NAME

MooseX::Attribute::ChainedClone - Accessor that returns a cloned object

=head1 VERSION

version 1.0.0

=head1 AUTHORS

=over 4

=item *

Moritz Onken <onken@netcubed.de>

=item *

David McLaughlin <david@dmclaughlin.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Moritz Onken.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

