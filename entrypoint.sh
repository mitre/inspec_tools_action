#!/bin/sh

set -e

echo $PATH
echo $INPUT_THRESHOLDFILE
echo $INPUT_RESULTSFILE
echo $INPUT_COMMAND

if [ -n $INPUT_THRESHOLDFILE ] && [ -n $INPUT_COMMAND ] && [ -n $INPUT_RESULTSFILE ]; then
  echo "Using $(inspec_tools version)"
  case "$INPUT_COMMAND" in
    "compliance" )
      inspec_tools compliance -j "$INPUT_RESULTSFILE" -f "$INPUT_THRESHOLDFILE"
      ;;
    "summary" )
      inspec_tools summary -j "$INPUT_RESULTSFILE" -t "$INPUT_THRESHOLDFILE"
      ;;
    * )
      echo "$INPUT_COMMAND is not a valid command";
      exit 1;
  esac
else
  echo "Thresholdfile, command, and resultfile inputs are required.";
  exit 1;
fi
