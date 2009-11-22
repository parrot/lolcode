=head1 TITLE

lolcode.pir - A lolcode compiler.

=head2 Description

This is the base file for the lolcode compiler.

This file includes the parsing and grammar rules from
the src/ directory, loads the relevant PGE libraries,
and registers the compiler under the name 'lolcode'.

=head2 Functions

=over 4

=item onload()

Creates the lolcode compiler using a C<PCT::HLLCompiler>
object.

=cut

.HLL 'lolcode'

.namespace [ 'lolcode';'Compiler' ]

.sub '' :anon :load :init
    load_bytecode 'PCT.pbc'
    .local pmc parrotns, lolns, exports
    parrotns = get_root_namespace ['parrot']
    lolns = get_hll_namespace
    exports = split ' ', 'PAST PCT PGE P6metaclass'
    parrotns.'export_to'(lolns, exports)
.end

.include 'src/builtins.pir'
.include 'src/gen_grammar.pir'
.include 'src/parser/yarn_literal.pir'
.include 'src/gen_actions.pir'

.sub 'onload' :anon :load :init

    $P0 = new 'ResizablePMCArray'
    set_hll_global ['lolcode';'Grammar';'Actions'], '@?BLOCK', $P0

    $P0 = new ['PAST';'Stmts']
    set_hll_global ['lolcode';'Grammar';'Actions'], '$?BLOCK_SIGNATURE', $P0

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()
    $P1.'language'('lolcode')
    $P0 = get_hll_namespace ['lolcode';'Grammar']
    $P1.'parsegrammar'($P0)
    $P0 = get_hll_namespace ['lolcode';'Grammar';'Actions']
    $P1.'parseactions'($P0)
.end

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args>
to the lolcode compiler.

=cut

.sub 'main' :main
    .param pmc args

    $P0 = compreg 'lolcode'
    $P1 = $P0.'command_line'(args)
.end


=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

