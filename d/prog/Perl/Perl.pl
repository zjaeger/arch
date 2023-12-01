# Perl.pl
# last update: 2019-02-13

use strict;
use warnings;
use diagnostics;

# perldoc -f my   # functions
# perldoc -q sort # Perl FAQ
# perldoc intro
# perldoc perlglossary
# perldoc perlop
# perldoc perlvar
# perldoc perlintro
# perldoc perlstyle
# perldoc perlglossary

# debugger
cmd> perl -d -e "1;"

my $var; # its value is undef

use utf8;

# You turn off only the bits you need. 
  {
   no warnings 'uninitialized';
   $total = $total + $some_value;
  }

## -- Strings ------------------------------------------------------------------

my $city = 'R\'lyeh';
my $city = "R'lyeh";

## The q{} replaces single quotes and qq{} replaces double-quotes. This can eliminate much painful escaping.
$txt =  q{text 'aaa' "bbb" $ENV{'HOME'}\n} ; # as ''
$txt = qq{text 'aaa' "bbb" $ENV{'HOME'}\n} ; # as ""

my $reviewer = 'Adrian';
my $review   = qq{$reviewer wrote "This book is wonderful"};

my $review   = qq!$reviewer wrote "This book is awful"!;
my $review   = qq<$reviewer wrote "This book is awful">;
my $review   = qq[$reviewer wrote "This book is awful"];
my $review   = qq($reviewer wrote "This book is awful");
my $review   = qq@$reviewer wrote "This book is awful"@

## -- multirow string

my $letter = qq{
Dear $editor,

I really liked the subtitle that you rejected and beg you to reconsider.
It was brilliant and perfectly conveyed the tone of this book.
In caseyou want to reconsider, it's:

   "Get a job, hippy!"

Sincerely,

Ovid
};

my $get_customers_with_orders = <<"SQL";
SELECT c.id
FROM   customers c
       JOIN orders o ON c.id = o.customer_id
SQL

print <<"END";
Fractions: $fractions
Bits:      $bitstring
Result:    $accumulator
END

# SEQUENCE DESCRIPTION
#   \t       Tab
#   \n       Newline
#   \r       Carriage return
#   \x{263a} Wide hex character
#   \N{name} Named Unicode character

## -- Numbers ------------------------------------------------------------------

my $answer = 42;
my $body_temp_fahrenheit = 98.6;

my $answer     = 052;   # 42 in decimal
my $hex_number = 0xFF;  # 255 in decimal
my $hex_number = 0xff;  # also 255 in decimal

my $electron_mass = 9.1093822e-31;

my $number_of_stars_in_universe = 3e23;
my $number_of_stars_in_universe = 3E+23;
my $number_of_stars_in_universe = 3.0e+23;

# don't touch anything below this line
my $num         = .3;
my $bits        = 32 ;
my $accumulator = 0 ;
my $bitstring   = '' ;
 
my @fractions;
for( 1 .. $bits )
  {
   my $denominator = 2 ** $_;
   my $fraction = 1 / $denominator;
   if( $accumulator + $fraction <= $num )
     {
      push @fractions, "1/$denominator";
      $bitstring .= "1";
      $accumulator += $fraction;
     }
   else
     { $bitstring .= "0"; }
  }
my $fractions = join " + ", @fractions;
print <<"END";
Fractions: $fractions
Bits:      $bitstring
Result:    $accumulator
END

## -- Arrays -------------------------------------------------------------------

my $nine = 9;
my @stuff = ( 7, 'of', $nine );
print @stuff, "\n";
print "@stuff\n";
# it prints:
#  7of9
#  7 of 9

my @words  = ( "and", "another", "thing" );
my $first  = $words[0];
my $second = $words[1];
my $third  = $words[2];

my @words = ("THIS", "THAT");
$words[5] =  "BAD IDEA";
# @words: ('THIS', 'THAT', undef, undef, undef, 'BAD IDEA')

my @odds = qw( 1 3 5 charlie );
# the same:
my @odds = qw( 1, 3, 5, 'charlie' );

my @odds = qw! 1 3 5 charlie !;
my @odds = qw<1 3 5 charlie >;
my @odds = qw{ 1 3 5 charlie };
my @odds = qw[ 1 3 5 charlie ];

my @punctuation = qw[ . ; ! ( ) { } ];

my @array = ( 'this', 'is', 'an', 'array' );
for my $element (@array) { print "$element\n"; }

# --- slices
my @names = ('Alice', 'Bill', 'Cathy', 'Doug');
my @men   = @names[ 1, 3 ]; # Bill and Doug
my @women = @names[ 0, 2 ]; # Alice and Cathy

## -- Hashes -------------------------------------------------------------------

my %people = (
    "Alice", 1,
    "Bob",   2,
    "Ovid",  "idiot",
);

print $people{'Alice'};
for my $name ( keys %people ) { print "$name is $people{$name}\n"; }

my %french_word_for = (
    1, 'un',
    2, 'deux',
    3, 'trois',
);
print "The French word for '3' is $french_word_for{3}\n";

$people{Austen} = 'Jane';
%people = ( %people, Austen => 'Jane', Lincoln => 'Abraham' );

my %nationality_of = (
   'Ovid'          => 'Greek',
   'John Davidson' => 'Scottish',
   'Tennyson'      => 'English',
   'Poe'           => 'Tacky',    # Geek?
);
 
# --- slices
my @nationalities = @nationality_of{ 'Ovid', 'Tennyson' };
print "@nationalities";

## -- Slices -------------------------------------------------------------------

my @names = ('Alice', 'Bill', 'Cathy', 'Doug');
my @men   = @names[ 1, 3 ]; # Bill and Doug
my @women = @names[ 0, 2 ]; # Alice and Cathy

my %nationality_of = (
   'Ovid'          => 'Greek',
   'John Davidson' => 'Scottish',
   'Tennyson'      => 'English',
   'Poe'           => 'Tacky',    # Geek?
);
 
my @nationalities = @nationality_of{ 'Ovid', 'Tennyson' };
print "@nationalities";

## -- Context ------------------------------------------------------------------

# --- scalar context
my $number_of_things = @things_in_common;
my $number_of_things = scalar @things_in_common;
my $number_of_things = ( 'liars', 'fools', 'certain politicians' );
my $number_of_things = %hash_example;

my @things_in_common = ( 'liars', 'fools', 'certain politicians' );
my $number_of_things = scalar @things_in_common;

@counts = ( scalar @a, scalar @b, scalar @c );

# --- list context
my @copy = @old_array;

my %hash = ( 1 => 2 ); # -- nonsence
print scalar %hash;
# prints: 1/8

# --- array context
my @copy = @old_array;
my %order_totals = (
    Charles     => 13.2,
    Valerie     => 17.9,
    'Billy Bob' => 0,
);
my @flattened = %order_totals;
print "@flattened\n" ;
# prints:
#   Billy Bob 0 Charles 13.2 Valerie 17.

my @swords = ( 'katana', 'wakizashi' );
my $number_of_swords = @swords;
my ($left_hand)      = @swords;
my ( $left_hand, $right_hand ) = @swords;

( $right_hand, $left_hand ) = ( $left_hand, $right_hand );
my ( $first, @extra ) = ( 1, 2, 3, 4 );

## --- scope -------------------------------------------------------------------

my $answer = 42;
  {
   my $answer = 'forty-two';
   print "$answer\n";
  }
print "$answer\n";

# -- That prints the following:
forty-two
42

## -- Perl's built-in variables ------------------------------------------------

$_

for (@array) { print "$_\n"; } # the same as: for my $element (@array) { print $element }

%ENV
@ARGV

# VARIABLE    DESCRIPTION
  @_          # Parameters passed to a subroutine
  $0          # The name of your program
  $a,$b       # Special global variables used in sort subroutines
  %ENV        # Hash containing your environment variables
  @INC        # Contains paths to look for files loaded with do, require, or use
  %INC        # Contains entries for every file loaded with do, require, or use
  $^V         # The current Perl version (Perl 5.6.0 or later)
  $^X         # The executable used to execute your program
  $1,$2,. . . # Subpatterns extracted from regular expressions
  $!          # Value of system error calls
  $@          # Perl syntax error trapped by eval

## -- Working with Data --------------------------------------------------------

$ perldoc -f builtin: 
$ perldoc -f chomp
$ perldoc -f ucfirst

# chop() and chomp()
chop (defauls to $_)
chop VARIABLE
chop( LIST )
# Actually, chomp() removes whatever is stored in the $/ variable, also known as the input record separator
chomp (defaults to $_)
chomp VARIABLE
chomp( LIST )

# chr() and ord()
chr (defaults to $_)
chr NUMBER
# ord() -  returns the numeric value of the first character in the string passed to it
ord (defaults to $_)
ord STRING

# index() and rindex()
# return -1 => SUBSTR not found
index  STR,SUBSTR,POSITION
index  STR,SUBSTR
rindex STR,SUBSTR,POSITION
rindex STR,SUBSTR

# lc(), lcfirst(), uc(), and ucfirst()
lc      (defaults to $_)
lc      EXPR
lcfirst (defaults to $_)
lcfirst EXPR
uc      (defaults to $_)
uc      EXPR
ucfirst (defaults to $_)
ucfirst EXPR

# length()
length (defaults to $_)
length EXPR

# pack() and unpack()
pack   TEMPLATE, LIST
unpack TEMPLATE, VARIABLE
unpack TEMPLATE

#                    .       .    .  .
my $record = '20080417john    39552027';
my ( $hired, $user, $emp_number, $dept ) = unpack 'A8A8A5A3', $record;

# print()
print (defaults to $_)
print FILEHANDLE LIST
print LIST

print $name;
print STDOUT $name;
print STDERR $name;

# sprintf() and printf()
sprintf FORMAT, LIST
printf  FILEHANDLE FORMAT, LIST
printf  FORMAT, LIST

# substr(), OFFSET starts on 0
substr EXPR,OFFSET,LENGTH,REPLACEMENT
substr EXPR,OFFSET,LENGTH
substr EXPR,OFFSET

# tr/// and y///
VARIABLE =~ tr/SEARCHLIST/REPLACEMENTLIST/cds
VARIABLE =~  y/SEARCHLIST/REPLACEMENTLIST/cds

my $string = "Aramis,Athos,Portos";
$string =~ tr/,/\t/;
print $string;

# string operators

# Repetition Operator: x
STRING   x INTEGER
(STRING) x INTEGER

# Concatenation Operator: .
STRING . STRING

# The "Whatever" Operator
STRING .. STRING

my @alphabet = ( 'a' .. 'z' );

http://perlmeme.org/faqs/manipulating_text/string_characters.html
my $string = "Hello, how are you?";
my @chars = split(//, $string ) ;
my @chars = unpack("C*", $string);
my @chars = $string =~ /./sg ; # /s - single line mode (The . metacharacter now matches \n).
my @chars = map substr( $string, $_, 1), 0 .. length($string) -1 ;

## -- Scalar::Util -------------------------------------------------------------

use Scalar::Util 'blessed'; # The blessed() function is useful to determine if a scalar is actually an object
# or
use Scalar::Util 'looks_like_number';
# or both
use Scalar::Util qw(blessed looks_like_number);
my $is_number = looks_like_number('3fred'); # false
my $is_number = looks_like_number('3e7');   # true!

## -- Numeric Builtins ---------------------------------------------------------

# Arithmetic Operators: +, -, *, /, and **
NUMBER + NUMBER
NUMBER - NUMBER
NUMBER * NUMBER
NUMBER / NUMBER
NUMBER ** NUMBER

# The Modulus Operator: %
INTEGER % INTEGER

# abs()
abs (defaults to $_)
abs NUMBER

# exp()
exp (defaults to $_)
exp NUMBER
# The exp() function returns e (approximately 2.718281828) to the power of the number passed to it.

# hex() and oct()
hex (defaults to $_)
hex STRING
oct (defaults to $_)
oct STRING

# int()
int (defaults to $_)
int NUMBER

# rand() and srand()
rand  NUMBER  # returns a random fractional number between 0 and the number passed to it.
srand NUMBER

# sprintf() and printf()
sprintf FORMAT, LIST
printf  FILEHANDLE FORMAT, LIST 
printf  FORMAT, LIST

# sqrt()
sqrt (defaults to $_)
sqrt NUMBER

# Trigonometric Function: atan2(), cos(), and sin()
atan2 (defaults to $_);
atan2 NUMBER
cos   (defaults to $_)
cos   NUMBER
sin   (defaults to $_)
sin   NUMBER

## -- Booleans -----------------------------------------------------------------

# eq, ne, lt, le, gt, ge, and cmp --- boolean string operators

# OPERATOR MEANING
  eq  Equal
  ne  Not equal
  lt  Less than
  le  Less than or equal to
  gt  Greater than
  ge  Greater than or equal to
  cmp String compare  # returns -1, 0, 1

my @sorted = sort { $a cmp $b } @words;
# the same:
my @sorted = sort @words;

# boolean numeric operators

# OPERATOR MEANING
==  Equal
!=  Not equal
<   Less than
<=  Less than or equal to
>   Greater than
>=  Greater than or equal to
<=> Numeric compare

my @sorted     = sort { $a <=> $b } @numbers;
my @descending = sort { $b <=> $a } @numbers;

# Boolean Operators

# OPERATOR TYPE MEANING
  !    Prefix  Equal
  &&   Infix   And
  ||   Infix   Or
  //   Infix   Defined or ( like nvl() )
  not  Infix   Not
  and  Infix   And
  or   Infix   Or
  xor  Infix   Exclusive or

# WHAT IS "TRUTH"?
# The following scalar values are all false in Perl:
  undef
  "" (the empty string)
  0
  0.0
  "0" (the “string” zero)
# Any other scalar value is true.

my $zero  = 0;
my $two   = 2;
my $three = 3;
my $x = $zero  && $two;   # $x is 0
my $y = $three && $zero;  # $y is 0
my $z = $two   && $three; # $z is 3

use 5.10.0; # tell Perl we want the // operator
my $zero  = 0;
my $two   = 2;
my $three = 3;
my $undef;
my $w = $zero  || $two;   # $w is 2
my $x = $undef || $zero;  # $x is 0
my $y = $zero  // $two;   # $y is 0!
my $z = $undef // $three; # $z is 3

# -- Bitwise Operators ---------------------------------------------------------
  &     # bitwise "and"
  |     # bitwise "or"
  ^     # bitwise "xor"
  ~     # bitwise negation (prefix)
  <<    # left shift operator
  >>    # right shift operator

# -- Assignment Operators ------------------------------------------------------

# OPERATOR EQUIVALENT EXPRESSION
  =        Assign rvalue to lvalue
  +=       lvalue = lvalue + rvalue
  -=       lvalue = lvalue - rvalue
  *=       lvalue = lvalue * rvalue
  /=       lvalue = lvalue / rvalue
  ||=      lvalue = rvalue if ! lvalue
  //=      lvalue = rvalue if ! defined lvalue
  &&=      lvalue = lvalue && rvalue
  |=       lvalue = lvalue | rvalue
  &=       lvalue = lvalue & rvalue
  **=      lvalue = lvalue ** rvalue
  x=       lvalue = lvalue x rvalue
  <<=      lvalue = lvalue << rvalue
  >>=      lvalue = lvalue >> rvalue
  ^=       lvalue = lvalue ^ rvalue

## -- ARRAY AND LIST FUNCTIONS -------------------------------------------------

# pop() and push()
pop  (defaults to @_)
pop  ARRAY
push ARRAY, LIST

# shift() and unshift()
# like the pop() and push() functions, but they operate on the beginning of the list.
shift   (defaults to @_)
shift   ARRAY
unshift ARRAY, LIST

# splice()
# function allows you to remove and return items from a list, starting with the OFFSET.
# If LENGTH is supplied, only LENGTH elements are removed.
# If a LIST is supplied, the removed elements are replaced with the LIST
splice ARRAY,OFFSET,LENGTH,LIST
splice ARRAY,OFFSET,LENGTH
splice ARRAY,OFFSET
splice ARRAY

# join() and split()
join STRING, LIST
split PATTERN, STRING
split PATTERN, STRING, LIMIT

# reverse()
reverse LIST

# sort()
sort LIST

my @sorted = sort @array;               # sorting alphabetically
my @sorted = sort { $b cmp $a } @array; # sorting alphabetically in reverse order
my @sorted = sort { $a <=> $b } @array; # sorting numerically
my @sorted = sort { $b <=> $a } @array; # sorting numerically in reverse order

# grep()
grep EXPR,  LIST
grep BLOCK, LIST

my @list = grep { $_ > 5 } @array ;  # get all values greater than 5:

# map()
map EXPR,  LIST
map BLOCK, LIST

my @doubled = map { $_ * 2 } @array ;

my @upper = map { uc($_) } @array;
my @upper = map { uc }     @array;

my @roots = map  { sqrt }
            grep { $_ > 0 }
            @numbers;

# List::Util
use List::Util 'sum';
my $total = sum @numbers;

## -- BUILT-IN HASH FUNCTIONS --------------------------------------------------

delete KEY

  my %birth_year_for = (
      Virgil                       => '70 BCE',
      Shakespeare                  => '1564 CE',
      'Elizabeth Barrett Browning' => '1806 CE',
      'Carrot Top'                 => '1965 CE',
  );
  delete $birth_year_for{'Carrot Top'};

exists KEY
keys HASH
values HASH

  my @large_enough = grep { $_ >= 10 } values %hash;

each HASH

  while ( my ( $key, $value ) = each %hash ) { print "$key: $value\n"; }

## -- SCOPING KEYWORDS ---------------------------------------------------------

my VARIABLE
my (LIST OF VARIABLES)

local VARIABLE
local (LIST OF VARIABLES)

our VARIABLE             # declare package variables in the current package
our (LIST OF VARIABLES)

use feature 'state';
# or
use 5.10.0;

state VARIABLE           # they are initialized only once and retain their value.

## -- CONTROL FLOW -------------------------------------------------------------

if ( !$color )              { print "No color found"; }
elsif ( 'blue'  eq $color ) { print "#0000FF"; }
elsif ( 'green' eq $color ) { print "#00FF00"; }
elsif ( 'red'   eq $color ) { print "#FF0000"; }
else                        { print "I don't know what to do with color ($color)"; }

# The Ternary Operator ?:
my $max = ( $num1 < $num2 ) ? $num2 : $num1;

# FOR/FOREACH LOOPS

for     my $number (@numbers) { print "$number\n"; }
foreach my $number (@numbers) { print "$number\n"; }

my @numbers = ( 5, 6, 7 );
foreach (@numbers) { print "$_\n"; }

for ( my $i = 0; $i < 10; $i++ ) { print "$i\n"; }

my $i = 10;
while ( $i > 0 ) {
   if ( rand(3) > 2 ) { $i++; }
   else               { $i--; }
   print $i,$/;
}

# last/next/redo/continue
  last()  # automatically exits a loop.
  next()  # skip the rest of the loop BLOCK

# it’s useful if you have a block of code that must be executed every time through a loop,
# before the loop check occurs again.
  for   (EXPRESSION) BLOCK continue BLOCK
  while (EXPRESSION) BLOCK continue BLOCK

DOUBLED_LETTER: foreach my $double (@strings1)
  {
   foreach my $word (@strings2)
     {
      if ( index($word, $double) != -1 ) { push @found, $double; next DOUBLED_LETTER; }
     }
  }
print "@found";

do BLOCK while EXPRESSION;
do BLOCK until EXPRESSION;

## -- STATEMENT MODIFIERS ------------------------------------------------------

STATEMENT if      EXPRESSION;
STATEMENT unless  EXPRESSION;
STATEMENT while   EXPRESSION;
STATEMENT until   EXPRESSION;
STATEMENT for     LIST;
STATEMENT foreach LIST;

my @array = ( 1 .. 5 );
print "$_\n" foreach @array;

## --- reg.expr. ---------------------------------------------------------------

foreach my $word (@words)
  {
   if( $word !~ /cat/ ) { print "$word\n"; }
  }

# equivalent:
foreach (@words)
  {
   if( !/cat/ ) { print "$_\n"; }
  }

# The following are all equivalent and match the string 1/2.
/1\/2/
m"1/2"
m{1/2}
m(1/2)

# qr() quote-like operator
my @strings = qw(
abba
abacus
abbba
babble
Barbarella
Yello
);
 
my @regexes = (
qr/ab?/,
qr/ab*/,
qr/ab+/,
);
foreach my $string (@strings)
  {
   foreach my $regex (@regexes)
     {
      if( $string =~ $regex ) { print "'$regex' matches '$string'\n"; }
     }
  }
# prints:
# '(?-xism:ab?)' matches 'abba'
# ...

# iter.
$txt = 'a1b2c3ddd44ee555ff66' ;
while( $txt =~ /(\d+)/g ) { print $1 ."\n" }
# prints:
#   1
#   2
#   3
#   44
#   555
#   66

# greedy: ON/OFF
my @Word = qw{ada arara arara cataract} ;
tst_1( qr/a(.+)a/,  \@Word ) ; # greedy
tst_1( qr/a(.+?)a/, \@Word ) ;

sub tst_1
  {
   my ( $re, $ra_Word ) = @_ ;
   my $w ;

   print '>>> '. $re ."\n" ;
   foreach $w ( @$ra_Word )
     {
      if( $w =~ $re )  { print $w .' ('. $1 .")\n" }
      else             { print $w ."\n" }
     }
   print "\n" ;
  }

# extracting data
if( "Phone: 123-456-7890" =~ /(\b\d{3}-\d{3}-\d{4}\b)/ )
  {
   my $phone = $1;
   print "The phone number is $phone\n";
  }

my $txt = '( select ID, round(a.FA, 2 ) as X from XXX )' ;
$txt =~ s/([()])/ \1 /g ;
$txt =~ s/([()])/ $1 /g ; # equivalent

# complex reg.expr.

my $cob_txt = <<'END' ;
10 XXX-Y1
15 XXX-Y1-ALFA PIC X(3)
15 XXX-Y1-BETA 9(3)
15 XXX-Y1-GAMA 99 OCCURS 04
END

my (@Rows, $row ) ;
@Rows = split(/\n/, $cob_txt ) ;
foreach $row ( @Rows )
  {
   #print $row ."\n" ;
   if( $row =~ /(\d+)
                \s+
                ([A-Z][-\w]+)
                .+?                      # greedy: off
                ([-+S9X][\(\)XV\.\d]+)?
               /x )                      # /x: all whitespace will be ignored
    {
     print '>>> ' .$row ."\n".
           join(';', ( $1, $2, $3 )) ."\n" ;
    }
  }

# Modifier Meaning
#   /x  Ignore unescaped whitepace.
#   /i  Case-insensitive match.
#   /g  Global matching (keep matching until no more matches).
#   /m  Multiline mode
#   /s  Single line mode (The . metacharacter now matches \n).

[\d\D]  - any character
[ ]{ }  - greedy
[ ]{ }? - lazy
[ ]{ }+ - possesive

# TEST: https://regex101.com/

## --- files -------------------------------------------------------------------

# FileHandle

  use FileHandle ;

  $fname = 'any_filename.x' ;

  $fh->open('>'. $fname ) ;
  print $fh '-- '. $fname ."\n\n" ;
  $fh->close() ;

# binmode

sub x_read
  {
   my ( $fname ) = @_ ;
   my ( $nbytes, $buff, $ix ) ;
   my ( @Vec, $val ) ;

   open( IN, $fname ) or die "Can't open file ". $fname .':'. $! ."\n\n" ;
   binmode( IN ) ;

   $nbytes = read( IN, $buff, 32 ) ;

   # variant 1
   @Vec = unpack('C*', $buff ) ;
   $ix = 0 ;
   foreach $val ( @Vec )
     {
      printf(" %02x", $val ) ;
      if( ++$ix == 16 ) { $ix = 0 ; print "\n" ; }
     }

   # variant 2
   print "\n" ;
   for( $ix = 0 ; $ix < $nbytes ; ++$ix )
     {
      $val = vec( $buff, $ix, 8 ) ;
      # printf("%d: %02x, %s\n", $ix, $val, $val ) ;
      printf(" %02x", $val ) ;
      if( (($ix+1) % 16) == 0 ) { print "\n" ; }
     }
   print "\n" ;

   close( IN ) ;
  }

## --- Data::Dumper ------------------------------------------------------------

use Data::Dumper;
my %hash = ('abc' => 123, 'def' => [4,5,6]);
print Dumper(\%hash);

## --- Example -----------------------------------------------------------------

# cru_OPRAVA.pl
#
# https://czjira.ness.com/browse/WSPK-37499
# MIGRACE - CRÚ - vynulování T_POL_P2
#
# Vstup: soubor pro CRU vygenerovaný ze Symbols (DVKP, K_OPER=U - uzávìrka)
# Výstup: vygenrovaný soubor pro vynulování T_POL:P2 (DVKP, K_OPER=O - oprava)
#
# 2021-06-25

use strict ;
use warnings ;
# use Data::Dumper;

# constants for selected tags
use constant {
  DVKP         => 'DVKP',
  DVKP_ZAZNAM  => 'DVKP_ZAZNAM',
  C_ZPRAVY     => 'C_ZPRAVY',
  K_OPER       => 'K_OPER',
  T_POL_P2     => 'T_POL_P2'
} ;

# ommited tags
my %h_tag_omt = (
 C_ZPRAVY,   1,
 'K_REZ',    1,
 'P_FORMA',  1,
 'SEKT',     1,
 'DIC',      1,
 'O_NAZEV',  1,
 'ULICE_S',  1,
 'MESTO_S',  1,
 'PSC_S',    1,
 'ZEME_S',   1,
 'ULICE_K',  1,
 'MESTO_K',  1,
 'PSC_K',    1,
 'ZEME_K',   1,
 'JMENO',    1,
 'PRIJMENI', 1,
 'TITUL',    1
) ;

# --- BEGIN ---

if( defined $ARGV[0] )
  {
   my $file_in = $ARGV[0] ;

   if( -f $file_in )
     {
      print 'Input file:  '. $file_in ."\n" ;
      gen_T_POL_P2( $file_in,'cru_OPRAVA.xml') ;
     }
   else
     { print STDERR $file_in .' - invalid filename.'."\n\n" }
  }
else
  {
   printf STDERR 'Usage: '. basename( $0 ) .' <cru_xml_file>'."\n\n" ;
  }

# --- END ---

sub basename
  {
   my ( $pathname ) = @_ ;
   my ( $pos1, $pos2, $pos ) ;

   $pos1 = rindex( $pathname,'\\') ;
   $pos2 = rindex( $pathname,'/') ;

   $pos = ( $pos1 > $pos2 ) ? $pos1 : $pos2 ;

   if( $pos > -1 )  { return substr( $pathname, $pos+1 ) }
   else             { return $pathname }
  }


sub get_value
# get value from row <tag>value</tag>
  {
   my ( $tag, $filler, $row, $row_no ) = @_ ;
   my ( $pos1, $pos2, $tag_len, $val ) ;

   $tag_len = length( $tag ) + 2 ;
   $pos1    = length( $filler ) + $tag_len ;
   $pos2    = index(  $row, '</'. $tag .'>', $pos1 ) -1 ;

   # print '< '. $pos1 .', '. $pos2 .' >, tag_len = '. $tag_len .', row_len = '. length( $row ) ."\n" ;

   if( $pos1 > 0 && $pos2 >= $pos1 && (($pos2 + $tag_len + 2) == length( $row )) )
     { $val = substr( $row, $pos1, $pos2 - $pos1 + 1 ) }
   else
     {
      $val = '' ;
      print STDERR $row_no .'>> invalid field: ' . $row ."\n" ;
     }
   return $val ;
  }


sub gen_T_POL_P2
  {
   my ( $file_in, $file_out ) = @_ ;
   my ( $in, $out, $row, $row_no, $tag, $end_flg, $filler ) ;
   my ( $rec_flg, $val, $buf, $t_pol_p2, $c_zpravy ) ;

   unless( open( $in, $file_in )) { print STDERR 'Error: open( '. $file_in .'): '. $! ."\n" }
   else
     {
      unless( open( $out,'>'. $file_out )) { print STDERR 'Error: open( >'. $file_out .'): '. $! ."\n" }
      else
        {
         print 'Output file: '. $file_out ."\n" ;
         print $out q{<?xml version = '1.0' encoding = 'Windows-1250'?>
<!DOCTYPE DVKP SYSTEM "dvkp.dtd">
<DVKP>
  <C_SOUBORU>0</C_SOUBORU>
  <P_ZPRAV>0</P_ZPRAV>
  <K_BANK>0800</K_BANK>
} ;
         $row_no = $t_pol_p2 = $c_zpravy = 0 ; $buf = '' ;
         while( $row = <$in> )
           {
            ++$row_no ;
            chomp( $row ) ;
            ( $filler, $end_flg, $tag ) = $row =~ /^(\s*)<(\/)*([\w]+)>/ ;
            if( ! defined $tag )     { $tag     = '' }
            if( ! defined $filler )  { $filler  = '' }
            if( ! defined $end_flg ) { $end_flg = '' }

            # print $row .' -> '. $tag .' >>'. $filler .'<< '. $end_flg ."\n" ;

            if( $tag eq DVKP_ZAZNAM ) # tag DVKP_ZAZNAM start/end
              {
               if( $end_flg eq '' ) { $rec_flg = 1 }
               else
                 {
                  $rec_flg = 0 ;
                  if( $t_pol_p2 > 0 )
                    {
                     $t_pol_p2 = 0 ;
                     ++$c_zpravy ;
                     print $out '<'. DVKP_ZAZNAM .'>'."\n".
                                '  <'. C_ZPRAVY .'>'. $c_zpravy .'</'. C_ZPRAVY .'>'."\n".
                                '  <'. K_OPER .'>O</'. K_OPER .'>'."\n".
                                $buf .
                                '</'. DVKP_ZAZNAM .'>'."\n" ;
                    }
                  $buf = '' ;
                 }
              }
            elsif( $rec_flg ) # field belogs to DVKP_ZAZNAM
              {
               $val = get_value( $tag, $filler, $row, $row_no ) ; # wel formed test also (expected form only: <tag>value</tag>)
               if( ! exists $h_tag_omt{ $tag } )                  # ommited tag test
                 {
                  if( $tag eq K_OPER )
                    {
                     if( $val ne 'U') { $rec_flg = 0 ; print STDERR 'Skip('. $row_no .'): '. $row ."\n" ; }
                    }
                  else
                    {
                     if( $tag eq T_POL_P2 )
                       {
                        $t_pol_p2 = $val ;
                        if( $t_pol_p2 > 0 ) { $buf .= $filler .'<'. $tag .'>0</'. $tag .'>'."\n" }
                       }
                     else
                       { $buf .= $row ."\n" }
                    }
                 }
              }
           }
         print $out '</'. DVKP .'>'."\n" ;
         close( $out ) ;
        }
      close( $in ) ;
     }
  }

