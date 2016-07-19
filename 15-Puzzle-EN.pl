#! usr/bin/env perl
####################################################
# DAME: 15 Puzzle Perl #############################
# AUTHOR: Arsenii Gorkin <gorkin@protonmail.com ####
# License: For commercial free use only, please ####
# Year: 2016 #######################################
####################################################

# Greeting
print <<HD;
"Welcome to the game \"15 Puzzle Perl\"!\n\n
Rules are really easy:\n
1) Нit the buttons on your keyboard to move a tile as if you would played in a common action game:\n
\tW - UP,\n
\tS - DOWN,\n
\tA - LEFT\n
\tD - RIGHT.\n
2) Then an\"Enter\" key.
This will move tiles with numbers immediately around the empty cell (horizontally or vertically).\n
3) A screen with a new updated board will be shown after each move.\n\n
VECTORY: Once you will place all the tiles in the ascending order from 1 to 15,
where the last tile is an eampty (16th) - you win!\n
Note: sometimes there can be two neighboring tiles by horisontal can be confused. This pair must be 14 and 15 tiles only.
If you assemble the game from 1 to 15 in the ascending order with the empty cell on 16th place,
but 14th and 15th tiles will be confused between each other the game ASLO will be finished with your victory.\n\n
\nGood luck and have fun!\n\n
HD

# Init
use warnings;
use Switch;

my (@A, @B, @C, @D, $INPUT);


#@A = ("1",  "2", "3", "4");
#@B = ("5",  "6", "7", "8");
#@C = ("9",  "10", "11", "12");
#@D = ("13",  "14", "15", "  ");

my @mainArray = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, " "); # Main array.
my @mainArrayCP = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, " "); # Array for matching the result (meant winning combination)
my @mainArrayCPR = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 14, " "); # One more winning array in case of confused 14th and 15th 

#exit switch
my $exiter = 0;

# Shuffling tiles
my $is = 16;
while ( --$is ){
	my $j = int rand( $is+1 );
	@mainArray[$is,$j] = @mainArray[$j,$is];
}

# Placing numbers by rows
@A = ($mainArray[0], $mainArray[1], $mainArray[2], $mainArray[3]);
@B = ($mainArray[4], $mainArray[5], $mainArray[6], $mainArray[7]);
@C = ($mainArray[8], $mainArray[9], $mainArray[10], $mainArray[11]);
@D = ($mainArray[12], $mainArray[13], $mainArray[14], $mainArray[15]);

$~ = "OUT";
write;

print "\nYour move, please:\n";
chomp ($INPUT = <>);

# Checking assembly
my $Finish = -1; # var for victory check
my $i = 1; # Moves counter.
while ($Finish ne 1) {
	# Checking input
	if ($INPUT =~/^[WSADwsad]$/) {
		
		$INPUT = uc $INPUT;
		
		# Checking tiles positioning
		my %lettersHash = (A=>0, B=>1, C=>2, D=>3);
		my @lettersArray = ("A", "B", "C", "D");
		
		# Checking presence of an empty cell around (in order with previous checks)
		my $moveTo; # Array's element which the current tile must be moved on (current empty cell)
		my $test = -1;
		my $EmptyCellArrayRef; # Address of the empty cell (initial point): Array Ref
		my $EmptyCellPos; # Address of the empty cell (иinitial point): element numebr
		my $ArrayNumber; # Number of the array with the empty cell
		my $CurCell; # Initial cell's information
		my $curCellPos; # Position of the current tile
		my $newArrayRef; # Array Ref to the array with the moving tile
		
		# Finding the empty cell for calculating the point of positioning from it
		for (0..3) {
			if ($A[$_] eq " ") {
				$EmptyCellPos = $_;
				$EmptyCellArrayRef = \@A;
				$ArrayNumber = 0;
				last;
			}
		}
		for (0..3) {
			if ($B[$_] eq " ") {
				$EmptyCellPos = $_;
				$EmptyCellArrayRef = \@B;
				$ArrayNumber = 1;
				last;
			}
		}
		for (0..3) {
			if ($C[$_] eq " ") {
				$EmptyCellPos = $_;
				$EmptyCellArrayRef = \@C;
				$ArrayNumber = 2;
				last;
			}
		}
		for (0..3) {
			if ($D[$_] eq " ") {
				$EmptyCellPos = $_;
				$EmptyCellArrayRef = \@D;
				$ArrayNumber = 3;
				last;
			}
		}
		
		switch ($INPUT) {
			case  "W" { # Checking UP move
				
				if ($ArrayNumber == 0) {
					$CurCell = $B[$EmptyCellPos];
					$newArrayRef = \@B;
					$curCellPos = $EmptyCellPos;
					$test = 1;
				}
				elsif ($ArrayNumber == 1) {
					$CurCell = $C[$EmptyCellPos];
					$newArrayRef = \@C;
					$curCellPos = $EmptyCellPos;
					$test = 1;
				}
				elsif ($ArrayNumber == 2) {
					$CurCell = $D[$EmptyCellPos];
					$newArrayRef = \@D;
					$curCellPos = $EmptyCellPos;
					$test = 1;
				}
			}
			case  "S" { # Checking DOWN move
				if ($ArrayNumber == 1) {
					$CurCell = $A[$EmptyCellPos];
					$newArrayRef = \@A;
					$curCellPos = $EmptyCellPos;
					$test = 1;
				}
				elsif ($ArrayNumber == 2) {
					$CurCell = $B[$EmptyCellPos];
					$newArrayRef = \@B;
					$curCellPos = $EmptyCellPos;
					$test = 1;
				}
				elsif ($ArrayNumber == 3) {
					$CurCell = $C[$EmptyCellPos];
					$newArrayRef = \@C;
					$curCellPos = $EmptyCellPos;
					$test = 1;
				}
			}
			case  "A" { # Checking LEFT move
				if ($EmptyCellPos >= 0  and $EmptyCellPos < 3) {
					if ($ArrayNumber == 0) {
						$CurCell = $A[$EmptyCellPos + 1];
						$newArrayRef = \@A;
						$curCellPos = $EmptyCellPos + 1;
						$test = 1;
					}
					elsif ($ArrayNumber == 1) {
						$CurCell = $B[$EmptyCellPos + 1];
						$newArrayRef = \@B;
						$curCellPos = $EmptyCellPos + 1;
						$test = 1;
					}
					elsif ($ArrayNumber == 2) {
						$CurCell = $C[$EmptyCellPos + 1];
						$newArrayRef = \@C;
						$curCellPos = $EmptyCellPos + 1;
						$test = 1;
					}
					elsif ($ArrayNumber == 3) {
						$CurCell = $D[$EmptyCellPos + 1];
						$newArrayRef = \@D;
						$curCellPos = $EmptyCellPos + 1;
						$test = 1;
					}
				}
			}
			case  "D" { # Checking RIGHT move
				if ($EmptyCellPos >= 1  and $EmptyCellPos <= 3) {
					if ($ArrayNumber == 0) {
						$CurCell = $A[$EmptyCellPos - 1];
						$newArrayRef = \@A;
						$curCellPos = $EmptyCellPos - 1;
						$test = 1;
					}
					elsif ($ArrayNumber == 1) {
						$CurCell = $B[$EmptyCellPos - 1];
						$newArrayRef = \@B;
						$curCellPos = $EmptyCellPos - 1;
						$test = 1;
					}
					elsif ($ArrayNumber == 2) {
						$CurCell = $C[$EmptyCellPos - 1];
						$newArrayRef = \@C;
						$curCellPos = $EmptyCellPos - 1;
						$test = 1;
					}
					elsif ($ArrayNumber == 3) {
						$CurCell = $D[$EmptyCellPos - 1];
						$newArrayRef = \@D;
						$curCellPos = $EmptyCellPos - 1;
						$test = 1;
					}
				}
			}
		} #Switch
		
		# Moving tiles
		if ($test == 1) {
			 
			# The move itself
			$EmptyCellArrayRef->[$EmptyCellPos] = $CurCell;
			$newArrayRef->[$curCellPos] = " ";
			
			# Checking if we could assemble the game?
			my @tempArray = ();
			push (@A, @tempArray);
			push (@B, @tempArray);
			push (@C, @tempArray);
			push (@D, @tempArray);
			print @tempArray;
			
			if (@mainArrayCP == @tempArray or @mainArrayCPR == @tempArray) {
				$Finish = 1;
				last;
			}
		}
		else {
			print "Your input $INPUT was wrong. Try againg. (Hint: W - up, S - down, A - left, D - right)\n";
			chomp ($INPUT = <>);
			next
		}
		$i++;
		$~ = "OUT";
		write;
		print "\nNext move (#$i), please:\n";
		chomp ($INPUT = <>);
	}
	#Checking exit case
	elsif ($INPUT =~/^X$/i or $INPUT =~/^exit$/i) {
		if ($exiter == 0) {
			print "Do you really want to exit? (Y for yes, N for continue): ";
			$exiter = 1;
			chomp ($INPUT = <>);
		}
		else {
			print "Ok. Just type Y for yes or N for continue playing, please, and hit Enter: ";
			$exiter = 1;
			chomp ($INPUT = <>);
		}
	}
	elsif ($INPUT =~/^y$/i and $exiter == 1) {
		print "Thank you for the game!\n";
		exit
	}
	elsif ($INPUT =~/^n$/i and $exiter == 1) {
		print "\n\nWelcome back!\n";
		$exiter = 0; #reseting exit switch
		$~ = "OUT";
		write;
		print "\nMake your next move (#$i), please:\n";
		chomp ($INPUT = <>);
	}
	else {
		print "Your input $INPUT was wrong. Try againg. (Hint: W - up, S - down, A - left, D - right)\n";
		$exiter = 0;
		chomp ($INPUT = <>);
	}

	
}






$~ = "OUT";
write;

print "Congratulations!\n\nYOU WON!\nYou have reached the victory in $i moves.\nThank you for the great game!\nGood bye!\n";
exit;

# Printing the results
format OUT = 
     ..1..   ..2..    ..3..   ..4..
     _____   _____    _____   _____
    |     | |     |  |     | |     |
A:  | @|| | | @|| |  | @|| | | @|| |
@A
    |     | |     |  |     | |     |
     _____   _____    _____   _____
    |     | |     |  |     | |     |
B:  | @|| | | @|| |  | @|| | | @|| |
@B
    |     | |     |  |     | |     |
     _____   _____    _____   _____
    |     | |     |  |     | |     |
C:  | @|| | | @|| |  | @|| | | @|| |
@C
    |     | |     |  |     | |     |
     _____   _____    _____   _____
    |     | |     |  |     | |     |
D:  | @|| | | @|| |  | @|| | | @|| |
@D
    |     | |     |  |     | |     |
     _____   _____    _____   _____
.
