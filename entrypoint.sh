#!/bin/sh

set -e

echo "Entering sleep"
sleep 600
echo "Done sleeping"

if [ -n $INPUT_THRESHOLDFILE ] && [ -n $INPUT_COMMAND ] && [ -n $INPUT_RESULTFILE ]; then
  echo "Using $(inspec_tools version)"
  case "$INPUT_COMMAND" in
    "compliance" )
      inspec_tools compliance -j "$INPUT_RESULTFILE" -f "$INPUT_THRESHOLDFILE"
      ;;
    "summary" )
      inspec_tools summary -j "$INPUT_RESULTFILE" -t "$INPUT_THRESHOLDFILE"
      ;;
    * )
      echo "$INPUT_COMMAND is not a valid command";
      exit 1;
  esac
else
  echo "Thresholdfile, command, and resultfile inputs are required.";
  exit 1;
fi
