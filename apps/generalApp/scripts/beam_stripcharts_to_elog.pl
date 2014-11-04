#!/bin/env perl 

# this script makes an entry in the operator log
# dumping the image of the epics beam scaler display

# $CLON_LIB/OPLOG.pm is included using PERLLIB environment variable
# Sergey is going to use CLON_PERL instead of CLON_LIB in the PERLLIB definition
use OPLOG;

use Pezca; 
use Tk;

$comment_string = 'Please enter informational comments here and click "Make Log Entry"\n';


# create the text entry widget
my $tk_main = MainWindow->new;

my $tk_label = $tk_main -> Label(-text=>'Beam stripcharts  Log Entry Comments');
$tk_label -> pack;
my $tk_text = $tk_main->Scrolled(Text,
				 -relief => sunken,
				 -borderwidth => 2,
				 -setgrid => true,
				 -width => 80,
				 -height => 20,
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
    $data_string = &MAKE_STRING;
    $comment =~ s/\'/\'\'/g;
    $comment .= "\n$data_string";

    print " $comment \n" ;

    $oplog = new OPLOG(database      => $database,
		       system_type   => 'beam',
		       lost_time     => '0',
		       email_address => 'stepanya@jlab.org',
		       subject       => 'Beam Stripcharts',
		       entry_type    => 'routine',
		       operators     => 'CLAS shift takers',
		       prev_id       => $prev_id,
		       );

    $run = $oplog->GET_RUN_NUMBER();
    $oplog -> OPLOG_SET(run => $run);

    $date_time = $oplog->GET_DATE_TIME();
    $oplog -> OPLOG_SET(entry_date => $date_time);

#    $data_string = &MAKE_STRING;

#    $comment =~ s/\'/\'\'/g;
#    $comment .= "\n$data_string";

#    print " $comment \n" ;

    $oplog -> OPLOG_SET(comment    => $comment );

    $ok = $oplog -> OPLOG_MAKE_ENTRY();

#    $key = $oplog->GET_UNIQUE_SEQ();

    $lok = $oplog-> OPLOG_DISCONNECT();
}
sub MAKE_STRING {

#    if ($#ARGV==0) exit(1);
    $window1="beam_current_electron.stc";
    $window2="bpm_x.stc";
    $window3="bpm_y.stc";
    
    $date=`date +%Y%m%d-%H:%M`;
    chomp $date;
    $png_on_web1 ="/LOGBOOK_IMAGES/${window1}-${date}.png";
    $png_on_disk1="/u/group/clas/www/clasweb/html".$png_on_web1;
    $png_on_web2 ="/LOGBOOK_IMAGES/${window2}-${date}.png";
    $png_on_disk2="/u/group/clas/www/clasweb/html".$png_on_web2;
    $png_on_web3 ="/LOGBOOK_IMAGES/${window3}-${date}.png";
    $png_on_disk3="/u/group/clas/www/clasweb/html".$png_on_web3;



#    print "$window\n$gif_on_disk\n\n$gif_on_web\n";
    system("xwd -name \"$window1 Graph\" | /usr/sfw/bin/convert - $png_on_disk1");
    system("xwd -name \"$window2 Graph\" | /usr/sfw/bin/convert - $png_on_disk2");
    system("xwd -name \"$window3 Graph\" | /usr/sfw/bin/convert - $png_on_disk3");
    $str="<img src=\"$png_on_web1\">\n<img src=\"$png_on_web2\">\n<img src=\"$png_on_web3\">\n";
    print "$str\n";

#    $adl=$ENV{'APP'}.'/medm/'.$window;
#    $str.=`grep chan= $adl | cut -d '=' -f 2 | sort | xargs caget`;
#    $str.=`grep ydata= $adl | cut -d '=' -f 2 | sort | xargs caget`;

    return($str);
}
