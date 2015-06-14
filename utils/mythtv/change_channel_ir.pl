#!/usr/bin/perl

# make sure to set this string to
# the corresponding remote in /etc/lircd.conf
$remote_name = "blaster";

# Let's assume you don't need to press enter after you punch in a
# channel number. Change this to 1 if your cable box expects you press
# enter after each command
$needs_enter = 0;

# Change this to point to your rc executable
$rc_command = "irsend";

# This subroutine actually sends the signal to the cable box
sub change_SIGNAL {
    my($SIGNAL) = @_;
    system ("$rc_command SEND_ONCE $remote_name $SIGNAL");
    system ("/bin/sleep 1");
}

$SIGNAL=$ARGV[0];
open F, ">> /var/log/mythtv/channel.log";
$sometime = localtime();
print F "$sometime: channel changing $SIGNAL\n";
close F;
print "channel changing $SIGNAL\n";

#wakeup
system ("$rc_command SEND_ONCE $remote_name EXIT");
system ("/bin/sleep 2");

# Checks if $SIGNAL begins with a digit
# If it detects that the string is made up of digits, then it puts
# spaces between the digits.  Ex. 1234 becomes 1 2 3 4
if ( $SIGNAL =~ /^\d+$/ )
{
    my $length = length($SIGNAL);
    my $counter = 0;
    my $temp;

    while( $counter < $length )
    {
	$temp .= substr($SIGNAL,$counter,1) ." ";
	$counter++;
    }

    change_SIGNAL($temp);
}
else
{
    # argument we passed was not made up of digits, so it must be a
    # command that does something other than channel changing on the
    # cable box
    change_SIGNAL($SIGNAL);
}

# Do we need to send enter
if ( $needs_enter )
{
    system ("$rc_command SEND_ONCE $remote_name ENTER");
}
