#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.
# $Id$

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    $P0 = new 'Hash'
    $P0['name'] = 'Lolcode'
    $P0['abstract'] = 'Lolcode'
    $P0['description'] = 'Lolcode'
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'Parrot Foundation'
    $P0['checkout_uri'] = 'https://svn.parrot.org/languages/lolcode/trunk'
    $P0['browser_uri'] = 'https://trac.parrot.org/languages/browser/lolcode'
    $P0['project_uri'] = 'https://trac.parrot.org/parrot/wiki/Languages'

    # build
    $P1 = new 'Hash'
    $P1['src/gen_grammar.pir'] = 'src/parser/grammar.pg'
    $P0['pir_pge'] = $P1

    $P2 = new 'Hash'
    $P2['src/gen_actions.pir'] = 'src/parser/actions.pm'
    $P0['pir_nqprx'] = $P2

    $P3 = new 'Hash'
    $P4 = split "\n", <<'SOURCES'
src/lolcode.pir
src/gen_grammar.pir
src/parser/yarn_literal.pir
src/gen_actions.pir
src/builtins.pir
src/builtins/cmp.pir
src/builtins/expr_parse.pir
src/builtins/math.pir
src/builtins/say.pir
SOURCES
    $P3['lolcode/lolcode.pbc'] = $P4
    $P3['lolcode.pbc'] = 'lolcode.pir'
    $P0['pbc_pir'] = $P3

    $P5 = new 'Hash'
    $P5['parrot-lolcode'] = 'lolcode.pbc'
    $P0['installable_pbc'] = $P5

    # test
    $S0 = get_parrot()
    $S0 .= ' lolcode.pbc'
    $P0['prove_exec'] = $S0

    # install
    $P0['inst_lang'] = 'lolcode/lolcode.pbc'

    # dist
    $P0['doc_files'] = 'TODO'

    .tailcall setup(args :flat, $P0 :flat :named)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
