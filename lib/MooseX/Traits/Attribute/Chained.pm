#
# This file is part of MooseX-Accessor-Chained
#
# This software is copyright (c) 2012 by Moritz Onken.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
package MooseX::Traits::Attribute::Chained;
{
  $MooseX::Traits::Attribute::Chained::VERSION = '1.0.0';
}
# ABSTRACT: DEPRECATED
use Moose::Role;
use MooseX::ChainedAccessors::Accessor;
use MooseX::ChainedAccessors;

sub accessor_metaclass { $Moose::VERSION >= 1.9900 ? 'MooseX::ChainedAccessors' : 'MooseX::ChainedAccessors::Accessor' }

no Moose::Role;
1;




=pod

=head1 NAME

MooseX::Traits::Attribute::Chained - DEPRECATED

=head1 VERSION

version 1.0.0

=head1 SYNOPSIS

    has => 'debug' => (
        traits => [ 'Chained' ],
        is => 'rw',
        isa => 'Bool',
    );

=head1 DESCRIPTION

Modifies the Accessor Metaclass to use MooseX::ChainedAccessors::Accessor

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


__END__

