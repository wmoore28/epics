#!/bin/env perl 

# this script makes an entry in the operator log
# dumping the image of the epics beam scaler display

# $CLON_LIB/OPLOG.pm is included using PERLLIB environment variable
# Sergey is going to use CLON_PERL instead of CLON_LIB in the PERLLIB definition
use OPLOG;

use Pezca; 
use Tk;


$comment_string = '';


# create the text entry widget
my $tk_main = MainWindow->new;

my $tk_label = $tk_main -> Label(-text=>'Enter additional Log Entry Comments');
$tk_label -> pack;
my $tk_text = $tk_main->Scrolled(Text,
				 -relief => sunken,
				 -borderwidth => 2,
				 -setgrid => true,
				 -width => 60,
				 -height => 5,
				 -scrollbars=>'e'
				 );

my $tk_ok_button = $tk_main->Button(-text => 'Make Log Entry',
				    -command => [\&make_elog_entry, $tk_text]);
my $tk_dismiss = $tk_main->Button(-text=>'DISMISS',
				  -command=>[$tk_main => 'destroy']);
$tk_text->insert('0.0',$comment_string);
$tk_text->mark(qw/set insert 0.0/);

$tk_text->pack(qw/-expand yes -fill both/);
$tk_ok_button -> pack(-side=> 'left',
		      -padx=>2);
$tk_dismiss -> pack(-side=>'right',
		    -padx=>2);

MainLoop;

sub make_elog_entry {
    my ($my_text) = @_;
    $comment = $my_text->get('1.0','end');
    $tk_main ->destroy();

    $database = 'clasprod';
    if ($database =~ /clasprod/) {
	$prev_id = 7323;
    } else {
	$prev_id = 3003;
    }

# Get window paramaters and find the date
    $winId=$ARGV[0];
    $window=$ARGV[1];
    $date=`date +%Y%m%d-%H:%M`;
    chomp $date;
# determine path-es on web and on disk, then snapshot and create image
    $gif_on_web ="/LOGBOOK_IMAGES/${window}-${date}.gif";
    $gif_on_disk="/u/group/clas/www/clasweb/html".$gif_on_web;
    system("xwd -id $winId | convert - $gif_on_disk");
    $data_string="<img src=\"$gif_on_web\">\n";
    print "$window $winId\n$gif_on_disk\n$gif_on_web\n";

# create list of PVes and their values
    $adl=$ENV{'APP'}.'/medm/'.$window;
    $str=`grep  chan= $adl | cut -d '=' -f 2 | sort`; $str =~ tr/\n\"/ /; if (length($str)>1) { $data_string .=`caget $str`; }
    $str=`grep  rdbk= $adl | cut -d '=' -f 2 | sort`; $str =~ tr/\n\"/ /; if (length($str)>1) { $data_string .=`caget $str`; }
    $str=`grep ydata= $adl | cut -d '=' -f 2 | sort`; $str =~ tr/\n\"/ /; if (length($str)>1) { $data_string .=`caget $str`; }

# making comment
    $comment =~ s/\'/\'\'/g;
    $comment .= "\n$data_string";

    print " $comment \n" ;



    $oplog = new OPLOG(database      => $database,
		       system_type   => 'beam',
		       lost_time     => '0',
		       email_address => 'stepanya@jlab.org',
		       subject       => "Snapshot of $window",
		       entry_type    => 'routine',
		       operators     => 'CLAS shift takers',
		       prev_id       => $prev_id
		       );

    $run = $oplog->GET_RUN_NUMBER();
    $oplog -> OPLOG_SET(run => $run);

    $date_time = $oplog->GET_DATE_TIME();
    $oplog -> OPLOG_SET(entry_date => $date_time);

#    $data_string = &MAKE_STRING;

    $oplog -> OPLOG_SET(comment    => $comment );

    $ok = $oplog -> OPLOG_MAKE_ENTRY();

#    $key = $oplog->GET_UNIQUE_SEQ();

    $lok = $oplog-> OPLOG_DISCONNECT();
}
