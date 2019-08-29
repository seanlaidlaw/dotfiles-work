#!/usr/bin/env bash

# a script for the easy launching of jobs on the "farm", the Sanger Institute HPC.
# Allows a simplified syntax for launching jobs using the LSF system, and sends an
# email when job finishes with the results of the job

# Parse arguments
farmjobname=$1
ram=$2
cmd=$3

current_dir=$(pwd)
recipient="$USER@sanger.ac.uk"
output="$current_dir/$farmjobname.output.txt"
error="$current_dir/$farmjobname.error.txt"

# remove temp files from last jobs
rm -f $output
rm -f $error
rm -f ~/bin/email_template.html
rm -f ~/.sub.sh.status

outputdir=$current_dir
mkdir -p $outputdir


bsub -o $output -e $error -J $farmjobname -G $LSB_DEFAULTGROUP -q normal -R"select[mem>$ram] rusage[mem=$ram]" -M$ram "$cmd && echo 'completed' > ~/.sub.sh.status || echo 'exited' > ~/.sub.sh.status"

(while [ ! -f ~/.sub.sh.status ];do sleep 5; done; echo "<html><head><title>[Automated Message]: Farm Job $farmjobname Completed</title></head><body><p>Hello human,</p><p>This is an automated message that has been sent on completion of farm job named: $farmjobname.</p><p>The output of the command is the following :</br><p style='background: #f4f4f4; border: 1px solid #ddd; border-left: 3px solid #f36d33; color: #666; page-break-inside: avoid; font-family: monospace; font-size: 12px; line-height: 1.6; margin-bottom: 1.6em; max-width: 100%; overflow: auto; padding: 1em 1.5em; display: block; word-wrap: break-word;'>$(cat $output | sed 's/</\&lt;/g' | sed 's/>/\&gt;/g' | perl -pe 's/\n/<br>/g')</p></br></br><p>and the error of the command is:</br><p style='background: #f4f4f4; border: 1px solid #ddd; border-left: 3px solid #f36d33; color: #666; page-break-inside: avoid; font-family: monospace; font-size: 12px; line-height: 1.6; margin-bottom: 1.6em; max-width: 100%; overflow: auto; padding: 1em 1.5em; display: block; word-wrap: break-word;'>$(cat $error| sed 's/</\&lt;/g' | sed 's/>/\&gt;/g' | perl -pe 's/\n/<br>/g')</p></br></br><p>The working directory is at the following path:</br>$outputdir</p></br><p>The job was run on $HOSTNAME by $USER</p></br></br><p>Beep..Boop.. end of message</br></body></html>" > ~/bin/email_template.html &&  (echo "To: $recipient"; echo "Subject: [Automated Message]: Farm Job $farmjobname Completed"; echo "Content-Type: text/html"; echo; cat ~/bin/email_template.html; echo) | sendmail -t; rm -f ~/.sub.sh.status) &
