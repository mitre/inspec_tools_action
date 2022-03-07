# inspec_tools_action
THIS ACTION IS DEPRECATED. Use the [SAF Action](https://github.com/mitre/saf_action) instead.
GitHub Action for [Inspec Tools](https://github.com/mitre/inspec_tools)

## Input and Output Arguments
### Input
#### `command` (required)

One of the available commands from Inspec Tools.

**Note:** This action only supports the `compliance` and `summary` subcommands of Inspec Tools.

* `summary`: Parses an Inspec results JSON and displays the summary information from all of the tests that were run.
* `compliance`: Parses an Inspec results JSON to check if the compliance level meets a specified threshold. If the specified threshold is not met, an error code (1) is returned along with non-compliant elements.

#### `resultsfile` (required)

Filename of the file that contains the Inspec results JSON to examine.

#### `thresholdfile` (required)

Filename of the file that contains the Inspec Tools-format threshold file.

An example of the format of this file is found on the Inspec Tools [README](https://github.com/mitre/inspec_tools#yaml-file-or-in-line-threshold-definition-styles)

### Output

#### Status Codes

This action will report a non-zero exit code if the command did not meet the thresholds set in `thresholdfile` input.

## Example

This action is useful for validating IT infrastructure as code or infrastructure hardening code fixes security controls/compliance findings or does not open any new security controls or compliance issues.

Typical Steps:
* Push new feature to infrastructure as code repository
* Build new test infrastructure based off of previous step
* Validate test infrastructure meets compliance requirements with Inspec
* Use this action to define and enforce minimum thresholds for infrastructure compliance by requiring checks to pass in a pull request review

```
on: [pull-request]
jobs:
  inspec_check:
    runs-on: ubuntu-latest
    steps:
      - name: Run Inspec
        run: inspec exec test.rb -t ssh://user@hostname --reporter=json:/inspec-output/inspec_results.json
      - name: Upload Inspec Results
        uses: actions/upload-artifact@v2
        with:
          name: inspec_results
          path: /inspec-output/inspec_results.json

  inspec_tools_compliance:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code for Threshold
        uses: actions/checkout@v2
      - name: Download Inspec Results
        uses: actions/download-artifact@v2
        with:
          name: inspec_results
      - name: Inspec Tools Check Compliance
        uses: mitre/inspec_tools_action@main
        with:
          command: compliance
          resultfile: inspec_results.json
          thresholdfile: threshold.yaml
```

## Contributing, Issues and Support

### Contributing

Please feel free to look through our issues, make a fork and submit _PRs_ and improvements. We love hearing from our end-users and the community and will be happy to engage with you on suggestions, updates, fixes or new capabilities.

### Issues and Support

Please feel free to contact us by **opening an issue** on the issue board, or, at [inspec@mitre.org](mailto:inspec@mitre.org) should you have any suggestions, questions or issues. If you have more general questions about the use of our software or other concerns, please contact us at [opensource@mitre.org](mailto:opensource@mitre.org).

### NOTICE

© 2019-2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.
